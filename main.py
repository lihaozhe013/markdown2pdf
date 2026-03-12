import time
import shlex
from watchdog.observers import Observer
from pathlib import Path
from src.change_handler import MarkdownChangeHandler
from src.utils import config_class, run_cmd
from src.clear_emoji import remove_emojis_from_file

base_dir = Path(__file__).parent.resolve()
config = config_class(base_dir)

pandoc_args = [
    'pandoc',
    config.file_path.relative_to(base_dir).as_posix(),
    config.style_path.relative_to(base_dir).as_posix(),
    '-o',
    config.output_name,
    config.output_engine,
    '-M', f'title={config.title}',   
    '-M', f'author={config.author}',
]

pandoc_cmd = [
    'docker',
    'compose',
    'run',
    '--rm',
    'converter',
    shlex.join(pandoc_args)
]

def start_watching(path_to_watch, command):
    # Initialize the event handler and observer
    event_handler = MarkdownChangeHandler(base_dir, command)
    observer = Observer()
    
    # recursive=True allows monitoring within subdirectories
    observer.schedule(event_handler, path_to_watch, recursive=True)
    observer.start()
    
    print(f"Now monitoring all .md files in directory: '{path_to_watch}'")
    print(f"Press Ctrl+C to stop monitoring...")

    try:
        # Keep the main thread alive
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        observer.stop()
        print("\nMonitoring stopped.")
        
    # Wait until the thread terminates before exiting
    observer.join()

if __name__ == "__main__":
    start_watching(base_dir, pandoc_cmd)