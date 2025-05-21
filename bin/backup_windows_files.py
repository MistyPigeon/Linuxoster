import os
import shutil
import argparse

WINDOWS_EXTENSIONS = [
    ".exe", ".dll", ".bat", ".cmd", ".msi", ".vbs", ".ps1", ".lnk", ".sys"
]

def is_windows_file(filename):
    return any(filename.lower().endswith(ext) for ext in WINDOWS_EXTENSIONS)

def backup_windows_files(src_dir, dest_dir):
    if not os.path.exists(dest_dir):
        os.makedirs(dest_dir)
    for root, _, files in os.walk(src_dir):
        for file in files:
            if is_windows_file(file):
                src_file = os.path.join(root, file)
                rel_path = os.path.relpath(root, src_dir)
                dest_path = os.path.join(dest_dir, rel_path)
                if not os.path.exists(dest_path):
                    os.makedirs(dest_path)
                shutil.copy2(src_file, os.path.join(dest_path, file))
                print(f"Backed up: {src_file} -> {os.path.join(dest_path, file)}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Backup Windows files by extension.")
    parser.add_argument("src", help="Source directory")
    parser.add_argument("dest", help="Destination directory for backup")
    args = parser.parse_args()
    backup_windows_files(args.src, args.dest)
