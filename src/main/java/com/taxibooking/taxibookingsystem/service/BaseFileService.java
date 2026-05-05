package com.taxibooking.taxibookingsystem.service;

import com.taxibooking.taxibookingsystem.util.FileUtil;
import com.taxibooking.taxibookingsystem.util.FileSerializable;
import java.util.ArrayList;
import java.util.List;

/**
 * Simplified Base class for all services that use file persistence.
 */
public abstract class BaseFileService<T extends FileSerializable> {

    protected abstract String getFilePath();
    protected abstract T parseLine(String line);
    protected abstract String getId(T item);

    public List<T> getAll() {
        List<T> items = new ArrayList<>();
        List<String> lines = FileUtil.readFromFile(getFilePath());
        for (String line : lines) {
            if (line != null && !line.trim().isEmpty()) {
                T item = parseLine(line);
                if (item != null) {
                    items.add(item);
                }
            }
        }
        return items;
    }

    public void add(T item) {
        FileUtil.writeLine(getFilePath(), item.toCSV());
    }

    public void update(T updatedItem) {
        List<T> all = getAll();
        List<String> lines = new ArrayList<>();
        String updatedId = getId(updatedItem);
        
        for (T item : all) {
            if (getId(item).equals(updatedId)) {
                lines.add(updatedItem.toCSV());
            } else {
                lines.add(item.toCSV());
            }
        }
        FileUtil.overwriteFile(getFilePath(), lines);
    }

    public void delete(String id) {
        List<T> all = getAll();
        List<String> remainingLines = new ArrayList<>();
        for (T item : all) {
            if (!getId(item).equals(id)) {
                remainingLines.add(item.toCSV());
            }
        }
        FileUtil.overwriteFile(getFilePath(), remainingLines);
    }

    public T getById(String id) {
        for (T item : getAll()) {
            if (getId(item).equals(id)) {
                return item;
            }
        }
        return null;
    }
}
