# Linuxoster
a tool to help download linux for windows 11 PC,heres the full desc:
# Linuxoster (Perl + C + Java + Python + Lua + Kotlin )

A helper tool for Windows users preparing to switch to Linux.

## Features

- Choose and download a Linux ISO.
- Guidance for creating a bootable USB.
- C utility to backup files.

## Usage

1. Install [Strawberry Perl](https://strawberryperl.com/) (for Perl) and [MinGW](https://osdn.net/projects/mingw/) or another GCC compiler (for C) on Windows.
2. Run the Perl script:
   ```
   perl bin/switch-to-linux.pl
   ```
3. To backup files:
   - Compile the backup utility:
     ```
     gcc bin/backup_files.c -o backup_files
     ```
   - Run the backup:
     ```
     backup_files <source_file> <destination_file>
     ```
4. Use Rufus to create a bootable USB with the downloaded ISO.

---

**Note:**  
- The Perl script helps with preparation only.  
- Backup your important files before installing Linux!
