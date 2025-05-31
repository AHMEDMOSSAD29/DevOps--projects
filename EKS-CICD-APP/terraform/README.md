# 🚀 Terraform EKS Infrastructure

This Terraform module sets up a production-ready Amazon EKS cluster with supporting infrastructure:

- VPC and subnets (public/private)
- NAT Gateway and Internet Gateway
- EKS Cluster
- EKS Managed Node Group
- IAM Roles and Policies

---

## 📦 Prerequisites

- Terraform v1.3+
- AWS CLI configured with appropriate credentials
- kubectl

---
## ✅ Deploy Infrastructure
``` bash

terraform init
terraform plan -var-file prod.tfvars
terraform apply -var-file prod.tfvars
