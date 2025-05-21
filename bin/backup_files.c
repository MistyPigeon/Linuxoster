#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define BUFFER_SIZE 8192

// Simple file copy utility: backup_files <source> <destination>
int main(int argc, char *argv[]) {
    if (argc != 3) {
        printf("Usage: %s <source> <destination>\n", argv[0]);
        return 1;
    }

    FILE *src = fopen(argv[1], "rb");
    if (!src) {
        perror("Error opening source file");
        return 2;
    }
    FILE *dest = fopen(argv[2], "wb");
    if (!dest) {
        perror("Error opening destination file");
        fclose(src);
        return 3;
    }

    char buffer[BUFFER_SIZE];
    size_t bytes;
    while ((bytes = fread(buffer, 1, BUFFER_SIZE, src)) > 0) {
        fwrite(buffer, 1, bytes, dest);
    }

    fclose(src);
    fclose(dest);

    printf("Backup completed: %s -> %s\n", argv[1], argv[2]);
    return 0;
}
