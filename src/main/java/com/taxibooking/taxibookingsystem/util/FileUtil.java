package com.taxibooking.taxibookingsystem.util;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

/**
 * Utility class for file operations.
 * Handles reading and writing to text files for data persistence.
 */
public class FileUtil {

    // Base directory for data files
    private static final String DATA_DIR = "data/";

    /**
     * Ensures the data directory exists
     */
    private static void ensureDataDirectoryExists() {
        try {
            Path dataPath = Paths.get(DATA_DIR);
            if (!Files.exists(dataPath)) {
                Files.createDirectories(dataPath);
                System.out.println("Created data directory: " + dataPath.toAbsolutePath());
            }
        } catch (IOException e) {
            System.err.println("Failed to create data directory: " + e.getMessage());
        }
    }

    /**
     * Ensures a file exists, creates it if it doesn't
     */
    private static void ensureFileExists(String fileName) {
        ensureDataDirectoryExists();
        File file = new File(fileName);
        try {
            if (!file.exists()) {
                file.getParentFile().mkdirs();
                file.createNewFile();
                System.out.println("Created file: " + file.getAbsolutePath());
            }
        } catch (IOException e) {
            System.err.println("Failed to create file: " + fileName);
            e.printStackTrace();
        }
    }

    /**
     * Write a single line to a file (append mode)
     */
    public static void writeLine(String fileName, String data) {
        ensureFileExists(fileName);
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(fileName, true))) {
            bw.write(data);
            bw.newLine();
            System.out.println("Written to file: " + fileName);
        } catch (IOException e) {
            System.err.println("Error writing to file: " + fileName);
            e.printStackTrace();
        }
    }

    /**
     * Read all lines from a file
     */
    public static List<String> readFromFile(String fileName) {
        List<String> lines = new ArrayList<>();
        ensureFileExists(fileName);

        File file = new File(fileName);
        if (!file.exists()) {
            System.out.println("File does not exist: " + fileName);
            return lines;
        }

        try (BufferedReader br = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = br.readLine()) != null) {
                if (!line.trim().isEmpty()) {  // Skip empty lines
                    lines.add(line);
                }
            }
            System.out.println("Read " + lines.size() + " lines from: " + fileName);
        } catch (IOException e) {
            System.err.println("Error reading file: " + fileName);
            e.printStackTrace();
        }
        return lines;
    }

    /**
     * Overwrite a file with new content
     */
    public static void overwriteFile(String fileName, List<String> lines) {
        ensureFileExists(fileName);
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(fileName, false))) {
            for (String line : lines) {
                bw.write(line);
                bw.newLine();
            }
            System.out.println("Overwrote file: " + fileName + " with " + lines.size() + " lines");
        } catch (IOException e) {
            System.err.println("Error overwriting file: " + fileName);
            e.printStackTrace();
        }
    }

    /**
     * Alternative method for writing to file (append mode)
     */
    public static void writeToFile(String filePath, String content) {
        writeLine(filePath, content);
    }

    /**
     * Delete a file
     */
    public static boolean deleteFile(String fileName) {
        File file = new File(fileName);
        if (file.exists()) {
            boolean deleted = file.delete();
            System.out.println("File deletion " + (deleted ? "successful" : "failed") + ": " + fileName);
            return deleted;
        }
        return false;
    }

    /**
     * Check if file exists
     */
    public static boolean fileExists(String fileName) {
        return new File(fileName).exists();
    }
}