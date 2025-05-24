### Prometheus-Grafana with Ansible

#### 📌 Overview

This project automates the deployment of a monitoring stack using **Prometheus** and **Grafana**, orchestrated via **Ansible**. The goal is to provide an easy-to-deploy monitoring solution for Linux-based servers.

---
#### 🛠️ Tech Stack

- **Ansible** – for automation and configuration management
- **Prometheus** – for time-series monitoring
- **Grafana** – for visualization and dashboards
- **Linux (Ubuntu)** – target OS for deployment

#### ✅ Prerequisites

Before deploying, ensure the following:

- A control machine with Ansible installed (Linux/MacOS)
- One or more target hosts (Linux servers [ubuntu]) with:
  - SSH access enabled (provided [bash script](server-script.sh))
  - ~/.ssh/config have the following for easy ssh
    ```bashHost node01 
         HostName node01
         User ansible
         IdentityFile ~/.ssh/private-key-name
         StrictHostKeyChecking no

  - Python installed
- Inventory file listing IPs or hostnames of the target servers
- Basic understanding of Ansible and SSH keys

#### ⚙️ Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/AHMEDMOSSAD29/DevOps--projects.git
   cd DevOps--projects/prometheus-grafana-ansible
   ansible-playbook playbook.yaml
