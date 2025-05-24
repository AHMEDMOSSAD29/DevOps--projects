# 📊 Ansible Role: Grafana

This Ansible role automates the installation and basic configuration of **Grafana**, a powerful open-source platform for monitoring and observability. Grafana is used to visualize metrics collected by Prometheus and other data sources.

> This role is part of the [Prometheus-Grafana Monitoring Project](../../) in the [DevOps--projects repository](https://github.com/AHMEDMOSSAD29/DevOps--projects).

---

## 📚 Table of Contents

- [Overview](#overview)
- [Features](#features)
 
---

## 📝 Overview

This role installs Grafana on Linux systems, configures it to run as a service, and allows you to optionally define Prometheus as a data source and import pre-defined dashboards for system monitoring.

---

## ✨ Features

- Installs the official Grafana OSS package
- Adds and enables the Grafana APT/YUM repository
- Starts and enables the Grafana service
- Configures default admin credentials
- Optional:
  - Adds Prometheus as a data source
  - Imports Grafana dashboards via API

 
