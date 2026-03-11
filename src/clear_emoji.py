import emoji
import os
import shutil

def remove_emojis_from_file(filename):
    if not os.path.exists(filename):
        print(f"Cannot find {filename}")
        return

    try:
        backup_name = f"{filename}.bak"
        shutil.copy(filename, backup_name)
        with open(filename, 'r', encoding='utf-8') as f:
            content = f.read()

        clean_content = emoji.replace_emoji(content, replace='')

        with open(filename, 'w', encoding='utf-8') as f:
            f.write(clean_content)

        print(f"Succeed!")

    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    target_file = 'content.md'
    remove_emojis_from_file(target_file)