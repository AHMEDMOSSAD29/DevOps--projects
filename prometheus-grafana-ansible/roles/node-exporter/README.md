# 🖥️ Ansible Role: Node Exporter

This Ansible role installs and configures **Prometheus Node Exporter** on Linux systems to expose system-level metrics such as CPU, memory, disk, and network stats. It enables Prometheus to collect infrastructure metrics from all target nodes.

> 📂 This role is part of the [Prometheus-Grafana Monitoring Project](../../) within the [DevOps--projects repository](https://github.com/AHMEDMOSSAD29/DevOps--projects).

---

## 📚 Table of Contents

- [Overview](#overview)
- [Features](#features)
 
---

## 📝 Overview

**Node Exporter** is a widely-used Prometheus exporter for hardware and OS metrics exposed via an HTTP endpoint. This role simplifies the process of installing and running Node Exporter as a systemd service.

---

## ✨ Features

- Installs the specified version of Node Exporter
- Creates a dedicated system user
- Downloads and extracts the Node Exporter binary
- Sets up Node Exporter as a `systemd` service
- Opens port `9100` (optional, if firewall is managed)
- Starts and enables the service

 
