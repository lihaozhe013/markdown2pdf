from pathlib import Path
import shlex
from src.utils import config_class, run_cmd
from src.clear_emoji import remove_emojis_from_file

base_dir = Path(__file__).parent.resolve()
config = config_class(base_dir)

pandoc_args = [
    'pandoc',
    str(config.file_path.relative_to(base_dir)),
    str(config.style_path.relative_to(base_dir)),
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

def main():
    remove_emojis_from_file(config.file_path)
    run_cmd(base_dir, pandoc_cmd)

if __name__ == "__main__":
    main()
