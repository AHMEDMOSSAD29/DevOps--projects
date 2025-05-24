# 📡 Ansible Role: Prometheus

This Ansible role automates the installation and configuration of **Prometheus**, a powerful open-source monitoring and alerting toolkit, on Linux-based systems.

> This role is part of the [Prometheus-Grafana Monitoring Project](../../) within the [DevOps--projects repository](https://github.com/AHMEDMOSSAD29/DevOps--projects).

---

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
 

---

## 📝 Overview

This role installs Prometheus and sets up basic configuration files, system services, and firewall rules (optional). It ensures Prometheus is running as a systemd service and configured to monitor local targets or user-defined targets.

---

## ✨ Features

- Installs the latest version of Prometheus
- Creates required directories and user
- Deploys configuration file `prometheus.yml`
- Sets up Prometheus as a systemd service
- Opens default port `9090` (if firewalld is enabled)

 
