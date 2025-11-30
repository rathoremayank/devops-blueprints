# Linux Networking & Resource Debug

## Table of Contents
1. Introduction
2. Networking Tools: ss, netstat, tcpdump
3. High CPU/Memory Handling
4. Scenario-Based Interview Questions
5. References

---

## 1. Introduction
Linux offers robust tools for networking diagnostics and resource debugging. Mastering these tools is essential for troubleshooting connectivity, performance, and resource issues.

---

## 2. Networking Tools

### ss (Socket Statistics)
`ss` is a modern replacement for `netstat`, used to investigate sockets and network connections.

- List all TCP connections:
  ```sh
  ss -t -a
  ```
- Show listening ports:
  ```sh
  ss -ltn
  ```
- Show connections for a specific port:
  ```sh
  ss -t sport = :22
  ```
- Show process info with connections:
  ```sh
  ss -plnt

### netstat
`netstat` is a legacy tool for network statistics and connections.

  ```sh
  netstat -an
  ```
- Show listening ports:
  ```sh
  netstat -tuln
  ```
- Show routing table:
  ```sh
  netstat -r
  ```
- Show interface statistics:
  ```sh
  netstat -i

### tcpdump
`tcpdump` is a packet analyzer for capturing and inspecting network traffic.

- Capture all packets on interface:
  ```sh
  tcpdump -i eth0
  ```
- Capture packets for a specific port:
  ```sh
  tcpdump port 80
  ```
- Save capture to file:
  ```sh
  tcpdump -i eth0 -w capture.pcap
  ```
- Read from capture file:
  ```sh
  tcpdump -r capture.pcap
  ```
- Filter by host:
  ```sh
  tcpdump host 192.168.1.10
  ```

---

## 3. High CPU/Memory Handling

### Identifying High Resource Usage
  ```sh
  top
  htop
  ```
  - Press `P` for CPU, `M` for memory
- Use `ps` for process snapshots:
  ```sh
  ps aux --sort=-%cpu | head
  ps aux --sort=-%mem | head

### Handling High Usage
- Kill a process:
  ```sh
  kill <PID>
  kill -9 <PID> # force kill
  ```
- Renice a process (change priority):
  ```sh
  renice -n 10 -p <PID>
  ```
- Investigate with `strace` or `lsof`:
  ```sh
  lsof -p <PID>
  ```

---

## 4. Scenario-Based Interview Questions

### Q1: How do you list all listening TCP ports?
**Answer:**
- `ss -ltn` or `netstat -tuln`

### Q2: How do you capture network traffic for a specific port?
**Answer:**
- `tcpdump port 443`

### Q3: How do you identify which process is using the most CPU?
**Answer:**

### Q3a: How do you identify the top 10 CPU consuming processes?
**Answer:**
- `ps aux --sort=-%cpu | head -n 11`  # First line is header, next 10 are top consumers
- In `top`, press `P` and visually check the top 10 entries.

### Q3b: How do you identify the top 10 memory consuming processes?
**Answer:**
- `ps aux --sort=-%mem | head -n 11`  # First line is header, next 10 are top consumers
- In `top`, press `M` and visually check the top 10 entries.

### Q4: How do you find which process is using a specific port?
- `ss -plnt` or `netstat -plnt`

### Q5: How do you save and analyze network traffic for later?
**Answer:**
- `tcpdump -i eth0 -w file.pcap` and `tcpdump -r file.pcap`

### Q6: How do you handle a process consuming excessive memory?
**Answer:**
- Identify with `top` or `ps`, then `kill` or `renice` as needed

### Q7: How do you check the routing table?
**Answer:**
- `netstat -r`

---

## 5. References
- [ss man page](https://man7.org/linux/man-pages/man8/ss.8.html)
- [netstat man page](https://man7.org/linux/man-pages/man8/netstat.8.html)
- [tcpdump documentation](https://www.tcpdump.org/)
- [Linux Performance Tools](https://www.brendangregg.com/linuxperf.html)

---

This README provides practical examples and interview scenarios for Linux networking and resource debugging, focusing on connection analysis and high resource usage handling.
