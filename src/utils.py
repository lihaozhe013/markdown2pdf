import subprocess
import shlex
import yaml
import sys
import os
import platform
from pathlib import Path

class config_class:
    def __init__(self, base_dir):
        self.full_config = self.load_config(base_dir / 'config.yaml')
        self.file_name = self.full_config['file_name']
        self.file_path = base_dir / self.file_name

        file_name_no_extension = Path(self.file_path).stem
        pdf_name = f'{file_name_no_extension}.pdf'
        tex_name = f'{file_name_no_extension}.tex'
        if self.full_config['output_type'] == 'pdf':
            self.output_name = pdf_name
            if self.full_config['engine'] == 'pdflatex':
                self.output_engine = '--pdf-engine=pdflatex'
            elif self.full_config['engine'] == 'xelatex':
                self.output_engine = '--pdf-engine=xelatex'
            else:
                print(f'Error: Unknown pdf engine: {self.output_engine}')
                sys.exit(1)
        elif self.full_config['output_type'] == 'tex':
            self.output_name = tex_name
            self.output_engine = '--standalone'
        else:
            print(f'Error: Unknown output_type: {self.full_config['output_type']}')

        self.style_name = self.full_config['style']
        self.style_path = base_dir / 'styles' / f'{self.style_name}.yaml'
        
        self.author = self.full_config['author']
        self.title = self.full_config['title']

    def load_config(self, file_path):
        """
        Example Usage:
            db_host = config['database']['host']
        """
        with open(file_path, 'r', encoding='utf-8') as f:
            config = yaml.safe_load(f)
            return config


def run_cmd(work_dir, command):
    env = os.environ.copy()
    if platform.system() != 'Windows':
        env['UID'] = str(os.getuid())
        env['GID'] = str(os.getgid())

    print(f'Running Command: {shlex.join(str(arg) for arg in command)}')
    subprocess.run(command, cwd=work_dir, env=env, check=True)

def get_filenames_without_extension(directory_path):
    path = Path(directory_path)
    filenames = [f.stem for f in path.iterdir() if f.is_file()]
    return filenames