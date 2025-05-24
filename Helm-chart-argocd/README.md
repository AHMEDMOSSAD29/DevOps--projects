# TradeByte App Helm Chart

![Helm](https://img.shields.io/badge/Helm-3.0+-blue)
![Kubernetes](https://img.shields.io/badge/Kubernetes-1.20+-326CE5)
![Docker](https://img.shields.io/badge/Docker-20.10+-2496ED)

This repository provides a production-ready Helm chart for deploying the TradeByte Python application. The chart packages all necessary Kubernetes manifests with configurable parameters for easy deployment.

## Table of Contents
- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Detailed Installation](#detailed-installation)
  - [1. Clone Source Repository](#1-clone-source-repository)
  - [2. Create docker file then Build and Push Docker Image](#2-create-docker-file-then-build-and-push-docker-image)
  - [3. Create Kubernetes Manifests](#3-create-kubernetes-manifests)
  - [4. Create Helm Chart](#4-create-helm-chart)

## Prerequisites

Ensure you have the following tools installed:

- `git` - [Installation guide](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- `Docker` (v20.10+) - [Installation guide](https://docs.docker.com/get-docker/)
- Kubernetes cluster (Minikube recommended for local testing) - [Minikube setup](https://minikube.sigs.k8s.io/docs/start/)
- `kubectl` configured for your cluster
- `Helm` (v3.0+) - [Installation guide](https://helm.sh/docs/intro/install/)

## Quick Start

For immediate deployment using the pre-built chart:

```bash
git clone https://github.com/AHMEDMOSSAD29/tradebyte-app.git
cd tradebyte-app
helm install tradebyte-app tradebyte/
minikube service tradebyte-service
```
## Detailed-installation

### 1. Clone Source Repository
First, clone the original application repository:
```bash
git clone https://github.com/tradebyte/DevOps-Challenge.git
```
### 2. Create docker file then Build and Push Docker Image
here is my [docker image](https://hub.docker.com/repository/docker/ahmedmosaad112/tradebyte-app/tags/latest/sha256-5dab5940461efbbae940ab31c08d0eb74d7426608b072957968b4aedcc9436eb)

### 3. Create Kubernetes Manifests
[k8s Manifests](k8s)

### 4. Create Helm Chart
First, create tradebyte:
```bash
helm create tradebyte
```
second, convert k8s manifests files by replacing values in k8s files then put it into vlues.yaml file in the chart and then package tradebyte chart:
```bash
helm package tradebyte
```
third, deploy the application using the Helm chart:
```bash
Helm install tradebyte-app ./tradebyte
```

#### finally if you want to test my chart 
clone this repo 
```bash
git clone https://github.com/AHMEDMOSSAD29/tradebyte-app.git
```
then 
```bash
Helm install tradebyte-app tradebyte/
```
then
```bash
minikube service tradebyte-service
```



