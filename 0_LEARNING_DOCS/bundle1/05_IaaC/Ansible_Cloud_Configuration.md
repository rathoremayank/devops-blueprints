# Cloud Configuration Using Ansible

## Table of Contents
1. Introduction to Ansible
2. Core Ansible Concepts
3. Important Ansible Modules & Usage
4. Sample Inventory File
5. Sample Playbook
6. How Ansible Works
7. Installing Ansible
8. Upgrading Ansible
9. Ansible with Terraform
10. Scenario-Based Interview Questions & Answers

---

## 1. Introduction to Ansible
Ansible is an open-source automation tool for configuration management, application deployment, and orchestration. It uses simple YAML files (playbooks) and SSH for agentless operation.

**Key Features:**
- Agentless architecture
- Human-readable automation (YAML)
- Idempotent operations
- Extensible with modules and plugins

---

## 2. Core Ansible Concepts
- **Inventory:** List of hosts managed by Ansible
- **Playbook:** YAML file describing automation tasks
- **Module:** Reusable unit of work (e.g., install package)
- **Task:** Single action in a playbook
- **Role:** Group of tasks, files, templates, and variables
- **Facts:** System information gathered from hosts
- **Handlers:** Triggered by tasks for actions like service restarts

---

## 3. Important Ansible Modules & Usage
- **yum/apt:** Install packages on Linux
- **service/systemd:** Manage services
- **copy/template:** Copy files or templates
- **user:** Manage users
- **file:** Manage file properties
- **git:** Clone repositories
- **ec2/gcp_compute/azure_rm:** Manage cloud resources

**Example:**
```yaml
- name: Install nginx
  hosts: web
  tasks:
    - name: Install nginx
      apt:
        name: nginx
        state: present
```

---

## 4. Sample Inventory File
```ini
[web]
web1.example.com
web2.example.com

group1 ansible_host=192.168.1.10 ansible_user=ubuntu
```

---

## 5. Sample Playbook
```yaml
- name: Configure Web Servers
  hosts: web
  become: yes
  tasks:
    - name: Install Nginx
      apt:
        name: nginx
        state: present
    - name: Start Nginx
      service:
        name: nginx
        state: started
```

---

## 6. How Ansible Works
1. Reads inventory to find hosts
2. Connects via SSH (or WinRM for Windows)
3. Executes modules remotely
4. Gathers facts and runs tasks
5. Reports results

**Workflow:**
- Write playbook
- Run `ansible-playbook` command
- Ansible executes tasks on target hosts

---

## 7. Installing Ansible
**On Linux:**
```sh
sudo apt update
sudo apt install ansible
```
**On macOS:**
```sh
brew install ansible
```
**Using pip:**
```sh
pip install ansible
```

---

## 8. Upgrading Ansible
**Using pip:**
```sh
pip install --upgrade ansible
```
**On Linux:**
```sh
sudo apt update
sudo apt upgrade ansible
```

---

## 9. Ansible with Terraform
Ansible and Terraform are often used together:
- **Terraform:** Provisions infrastructure (VMs, networks)
- **Ansible:** Configures software and settings on provisioned resources

**Workflow Example:**
1. Use Terraform to create cloud VMs
2. Use Ansible to install and configure applications on those VMs

**Example Integration:**
```hcl
resource "aws_instance" "web" {
  ami           = "ami-123456"
  instance_type = "t2.micro"
}
```

After provisioning, use Ansible inventory generated from Terraform outputs.

---

## 10. Scenario-Based Interview Questions & Answers


---

## 20 Scenario-Based Interview Questions and Answers

### Core Ansible Concepts
#### 1. How does Ansible achieve agentless automation?
**Answer:** Ansible uses SSH (or WinRM for Windows) to connect to remote hosts, requiring no agent installation.

#### 2. What is an Ansible playbook?
**Answer:** A YAML file that defines automation tasks and their execution order for target hosts.

#### 3. What is the purpose of an inventory file?
**Answer:** It lists hosts and groups managed by Ansible, providing connection details.

#### 4. How do handlers work in Ansible?
**Answer:** Handlers are triggered by tasks (using `notify`) to perform actions like restarting services only when needed.

#### 5. What are Ansible facts?
**Answer:** Facts are system information collected from hosts, used for conditional logic in playbooks.

---

### Important Modules & Usage
#### 6. How do you install a package using Ansible?
**Answer:** Use the `apt` or `yum` module in a playbook task to install packages on target hosts.

#### 7. How do you manage services with Ansible?
**Answer:** Use the `service` or `systemd` module to start, stop, or restart services.

#### 8. How do you copy files to remote hosts?
**Answer:** Use the `copy` or `template` module in a playbook task.

#### 9. How do you manage users in Ansible?
**Answer:** Use the `user` module to create, modify, or delete users on target hosts.

#### 10. How do you manage cloud resources with Ansible?
**Answer:** Use cloud-specific modules like `ec2`, `gcp_compute`, or `azure_rm` to provision and manage resources.

---

### Inventory & Playbooks
#### 11. What is a sample inventory file format?
**Answer:** INI or YAML format listing hosts and groups, e.g., `[web] web1.example.com`.

#### 12. How do you structure a basic playbook?
**Answer:** Define `name`, `hosts`, `tasks`, and optionally `become` for privilege escalation.

#### 13. How do you run a playbook?
**Answer:** Use the `ansible-playbook <playbook.yml>` command.

#### 14. How do you use variables in Ansible?
**Answer:** Define variables in playbooks, inventory, or external files and reference them with `{{ variable }}`.

#### 15. How do you use roles in Ansible?
**Answer:** Roles organize tasks, files, templates, and variables for reuse and modularity.

---

### Installation & Upgrading
#### 16. How do you install Ansible on Linux?
**Answer:** Use `sudo apt install ansible` or `pip install ansible`.

#### 17. How do you upgrade Ansible?
**Answer:** Use `pip install --upgrade ansible` or your OS package manager.

---

### Ansible with Terraform
#### 18. How do you use Ansible after provisioning resources with Terraform?
**Answer:** Generate an inventory from Terraform outputs and run Ansible playbooks to configure the resources.

#### 19. What is the benefit of combining Ansible and Terraform?
**Answer:** Terraform handles infrastructure provisioning, while Ansible manages configuration, enabling full automation.

#### 20. How do you pass dynamic inventory from Terraform to Ansible?
**Answer:** Use Terraform output files or scripts to generate inventory files for Ansible.

---

## References
- [Ansible Official Documentation](https://docs.ansible.com/)
- [Ansible Modules List](https://docs.ansible.com/ansible/latest/collections/index_module.html)
- [Terraform and Ansible Integration](https://www.terraform.io/docs/integrations/ansible.html)
