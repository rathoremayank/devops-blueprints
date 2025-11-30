# Linux File & Disk Management

## Table of Contents
1. Introduction
2. File Operations: Opening, Reading, Writing
3. Pattern Matching
4. File Permissions
5. Hard and Soft Links
6. Disk Management
7. Scenario-Based Interview Questions
8. References

---

## 1. Introduction
Linux provides powerful tools for managing files and disks. Mastery of these operations is essential for system administration, troubleshooting, and automation.

---

## 2. File Operations: Opening, Reading, Writing

### Opening and Reading Files
- Using `cat`:
  ```sh
  cat filename.txt
  ```
- Using `less` or `more` for paginated viewing:
  ```sh
  less filename.txt
  more filename.txt
  ```
- Using `head` and `tail`:
  ```sh
  head -n 10 filename.txt
  tail -n 10 filename.txt
  ```

### Writing to Files
- Using `echo` and redirection:
  ```sh
  echo "Hello World" > file.txt   # Overwrite
  echo "Another line" >> file.txt # Append
  ```
- Using `tee`:
  ```sh
  echo "Log entry" | tee logfile.txt
  ```
- Using text editors: `nano`, `vim`, `gedit`

---

## 3. Pattern Matching
Pattern matching is used for searching and manipulating files.

- Using `grep`:
  ```sh
  grep "pattern" filename.txt
  grep -r "pattern" /path/to/dir
  ```
- Using wildcards in shell:
  ```sh
  ls *.txt
  rm file_??.log
  ```
- Using `find`:
  ```sh
  find /path -name "*.log"
  ```

---

## 4. File Permissions
Linux uses a permission model for security.

- View permissions:
  ```sh
  ls -l filename.txt
  ```
- Change permissions:
  ```sh
  chmod 644 filename.txt
  chmod +x script.sh
  ```
- Change ownership:
  ```sh
  chown user:group filename.txt
  ```

### Permission Types
- Read (r), Write (w), Execute (x)
- Owner, Group, Others

---

## 5. Hard and Soft Links

- Create a hard link:
  ```sh
  ln original.txt hardlink.txt
  ```
- Create a soft (symbolic) link:
  ```sh
  ln -s /path/original.txt symlink.txt
  ```
- List links:
  ```sh
  ls -li
  ```

### Differences
- Hard links share inode, soft links point to path
- Deleting original file breaks symlink, not hard link

---

## 6. Disk Management

### Viewing Storage
- Check disk usage:
  ```sh
  df -h
  du -sh /path/to/dir
  ```
- List block devices:
  ```sh
  lsblk
  fdisk -l
  ```

### Checking and Configuring Mounts
- View mounted filesystems:
  ```sh
  mount
  cat /etc/fstab
  ```
- Mount a device:
  ```sh
  mount /dev/sdb1 /mnt/data
  ```
- Unmount a device:
  ```sh
  umount /mnt/data
  ```

### Shrinking or Extending Volumes
- Use `resize2fs` for ext filesystems:
  ```sh
  resize2fs /dev/sda1
  ```
- Use `lvextend` and `lvreduce` for LVM:
  ```sh
  lvextend -L +10G /dev/vg0/lv0
  lvreduce -L -5G /dev/vg0/lv0
  resize2fs /dev/vg0/lv0
  ```
- Always backup before resizing!

---

## 7. Scenario-Based Interview Questions

### Q1: How do you find all files containing a specific pattern?
**Answer:**
- `grep -r "pattern" /path`

### Q2: How do you change a file's owner and permissions?
**Answer:**
- `chown user:group file.txt`
- `chmod 755 file.txt`

### Q3: How do you create a symbolic link and what happens if the original file is deleted?
**Answer:**
- `ln -s /path/original.txt symlink.txt`
- Symlink breaks if original is deleted

### Q4: How do you check disk usage and find large files?
**Answer:**
- `df -h` for disk usage
- `du -sh * | sort -h` to find large files

### Q5: How do you mount a new disk and make it persistent?
**Answer:**
- `mount /dev/sdb1 /mnt/data`
- Add entry to `/etc/fstab`

### Q6: How do you extend a logical volume?
**Answer:**
- `lvextend -L +5G /dev/vg0/lv0 && resize2fs /dev/vg0/lv0`

### Q7: How do you find and delete files older than 30 days?
**Answer:**
- `find /path -type f -mtime +30 -delete`

---

## 8. References
- [Linux File Management Guide](https://linuxize.com/post/how-to-manage-files-in-linux/)
- [Linux Permissions](https://www.tutorialspoint.com/unix/unix-file-permission.htm)
- [Disk Management in Linux](https://wiki.archlinux.org/title/disk_management)
- [LVM Guide](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/logical_volume_manager_administration/index)

---

This README provides practical examples and interview scenarios for Linux file and disk management, including permissions, links, and storage operations.
