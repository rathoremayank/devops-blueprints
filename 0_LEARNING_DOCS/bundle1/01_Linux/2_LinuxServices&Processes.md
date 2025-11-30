# Linux Services & Processes

## Linux Services and Process Management

### What are Linux Services?
Services (daemons) are background programs that provide core system functionality, such as networking, web hosting, and scheduling. They are managed by the init system (e.g., systemd) and typically run independently of user sessions.

**Key Features of Services:**
- Run in the background
- Start automatically at boot (if enabled)
- Managed by service managers (systemd, SysVinit, etc.)
- Have dedicated unit files (e.g., nginx.service)
- Can be started, stopped, restarted, enabled, or disabled

### What are Linux Processes?
Processes are instances of running programs. Every command or application executed by a user or service creates a process. Processes can be foreground (interactive) or background (detached).

**Key Features of Processes:**
- Represent running programs (user or system)
- Have unique Process IDs (PIDs)
- Can be parent or child processes
- Managed by the kernel
- Can be monitored and controlled (kill, renice, etc.)

### Differences Between Services and Processes
| Feature         | Services (Daemons)                | Processes                      |
|----------------|-----------------------------------|--------------------------------|
| Purpose        | Provide system-wide functionality | Any running program            |
| Management     | Managed by init/service manager   | Managed by kernel              |
| Startup        | Boot or on-demand                 | User or service initiated      |
| Lifecycle      | Long-running, persistent          | Short or long-lived            |
| Examples       | sshd, httpd, crond                | bash, vim, top, python script  |

**Summary:**
Services are specialized processes designed to run in the background and provide system functions, while processes are any running program, including services, user commands, and applications.

## Table of Contents
1. Introduction
2. systemd Unit Types
3. journald (Systemd Journal)
4. Troubleshooting Services
5. systemctl Usage
6. Monitoring with top
7. Log Tracing Techniques
8. Scenario-Based Interview Questions

---

## 1. Introduction
Linux services and processes are fundamental to system administration. Understanding how to manage, monitor, and troubleshoot them is essential for any Linux professional.

---

## 2. systemd Unit Types
`systemd` is the default init system for most modern Linux distributions. It manages system boot, services, and resources.

### Common Unit Types:
- **Service Unit (`.service`)**: Manages system services (daemons).
- **Socket Unit (`.socket`)**: Activates services based on socket activity.
- **Target Unit (`.target`)**: Groups units for synchronization (like runlevels).
- **Device Unit (`.device`)**: Manages device files.
- **Mount Unit (`.mount`)**: Handles mount points.
- **Timer Unit (`.timer`)**: Schedules tasks (like cron).
- **Path Unit (`.path`)**: Watches file system paths for changes.

#### Example: Service Unit File
```ini
[Unit]
Description=My Custom Service

[Service]
ExecStart=/usr/bin/myservice
Restart=always

[Install]
WantedBy=multi-user.target
```

---

## 3. journald (Systemd Journal)
`journald` is systemd's logging service, storing logs in a binary format.

### Key Features:
- Centralized logging for all services
- Persistent or volatile storage
- Structured log entries

### Useful Commands:
- View logs for a service:
  ```sh
  journalctl -u nginx.service
  ```
- View logs since boot:
  ```sh
  journalctl -b
  ```
- Follow logs in real-time:
  ```sh
  journalctl -f
  ```
- Filter by priority:
  ```sh
  journalctl -p err
  ```

---

## 4. Troubleshooting Services

### Steps:
1. Check service status:
   ```sh
   systemctl status apache2
   ```
2. View logs:
   ```sh
   journalctl -u apache2
   ```
3. Restart the service:
   ```sh
   systemctl restart apache2
   ```
4. Check for failed units:
   ```sh
   systemctl --failed
   ```
5. Analyze dependencies:
   ```sh
   systemctl list-dependencies apache2
   ```

---

## 5. systemctl Usage
`systemctl` is the main tool to interact with systemd.

### Common Commands:
- Start a service:
  ```sh
  systemctl start sshd
  ```
- Stop a service:
  ```sh
  systemctl stop sshd
  ```
- Enable service at boot:
  ```sh
  systemctl enable sshd
  ```
- Disable service:
  ```sh
  systemctl disable sshd
  ```
- Check service status:
  ```sh
  systemctl status sshd
  ```
- Reload all unit files:
  ```sh
  systemctl daemon-reload
  ```

---

## 6. Monitoring with top
`top` is a real-time process monitoring tool.

### Usage:
- Run `top`:
  ```sh
  top
  ```
- Sort by CPU usage: Press `P`
- Sort by memory usage: Press `M`
- Kill a process: Press `k` and enter PID
- Quit: Press `q`

#### Alternative Tools:
- `htop` (interactive, colorized)
- `ps` (snapshot of processes)

---

## 7. Log Tracing Techniques

### Tracing Service Logs:
- View logs for a specific time:
  ```sh
  journalctl --since "2025-11-01" --until "2025-11-30"
  ```
- Grep for keywords:
  ```sh
  journalctl -u sshd | grep "Failed"
  ```
- Export logs to text:
  ```sh
  journalctl -u nginx > nginx.log
  ```

---

## 8. Scenario-Based Interview Questions

### Q1: A service fails to start. How do you troubleshoot?
**Answer:**
- Check status: `systemctl status <service>`
- View logs: `journalctl -u <service>`
- Check dependencies: `systemctl list-dependencies <service>`
- Inspect unit file for errors

### Q2: How do you make a service start at boot?
**Answer:**
- `systemctl enable <service>`

### Q3: How do you trace why a process is consuming high CPU?
**Answer:**
- Use `top` or `htop` to identify the process
- Check logs for the process
- Use `strace` for system calls

### Q4: How do you view only error logs for a service?
**Answer:**
- `journalctl -u <service> -p err`

### Q5: How do you reload systemd after editing a unit file?
**Answer:**
- `systemctl daemon-reload`

### Q6: How do you find all failed services?
**Answer:**
- `systemctl --failed`

### Q7: How do you monitor real-time logs for a service?
**Answer:**
- `journalctl -u <service> -f`

---

## References
- [systemd Documentation](https://www.freedesktop.org/wiki/Software/systemd/)
- [Linux man pages: systemctl, journalctl, top]
- [Red Hat: Introduction to systemd](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/system_administrators_guide/chap-managing_services_with_systemd)
- [DigitalOcean: How To Use Journalctl](https://www.digitalocean.com/community/tutorials/how-to-use-journalctl-to-view-and-manipulate-systemd-logs)

---

This README provides a comprehensive overview and practical examples for Linux services and processes, focusing on systemd, journald, troubleshooting, and monitoring.