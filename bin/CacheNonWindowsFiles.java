import java.io.*;
import java.nio.file.*;
import java.util.*;

public class CacheNonWindowsFiles {
    public static void main(String[] args) {
        if (args.length != 2) {
            System.out.println("Usage: java CacheNonWindowsFiles <root_directory> <cache_directory>");
            System.exit(1);
        }

        String rootDir = args[0];
        String cacheDir = args[1];

        File cacheFolder = new File(cacheDir);
        if (!cacheFolder.exists()) {
            if (!cacheFolder.mkdirs()) {
                System.out.println("Failed to create cache directory.");
                System.exit(1);
            }
        }

        List<String> windowsExtensions = Arrays.asList(
            ".exe", ".dll", ".bat", ".cmd", ".msi", ".vbs", ".ps1", ".lnk", ".sys"
        );

        try {
            Files.walk(Paths.get(rootDir))
                .filter(Files::isRegularFile)
                .forEach(path -> {
                    String fileName = path.getFileName().toString().toLowerCase();
                    boolean isWindowsFile = false;
                    for (String ext : windowsExtensions) {
                        if (fileName.endsWith(ext)) {
                            isWindowsFile = true;
                            break;
                        }
                    }
                    if (!isWindowsFile) {
                        File srcFile = path.toFile();
                        File destFile = new File(cacheDir, srcFile.getName());
                        try (InputStream in = new FileInputStream(srcFile);
                             OutputStream out = new FileOutputStream(destFile)) {
                            byte[] buffer = new byte[8192];
                            int len;
                            while ((len = in.read(buffer)) > 0) {
                                out.write(buffer, 0, len);
                            }
                            System.out.println("Cached: " + srcFile.getAbsolutePath());
                        } catch (IOException e) {
                            System.out.println("Failed to cache: " + srcFile.getAbsolutePath());
                        }
                    }
                });
        } catch (IOException e) {
            System.out.println("Error traversing directory: " + e.getMessage());
        }
    }
}
