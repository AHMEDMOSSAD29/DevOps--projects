variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  # default     = "eks-cluster"
}

variable "region" {
  description = "AWS region"
  type        = string
  # default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  # default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  # default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
  # default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "node_group_instance_types" {
  description = "EC2 instance types for the node group"
  type        = list(string)
  # default     = ["t2.micro"]
}

variable "desired_capacity" {
  description = "Desired number of nodes in the node group"
  type        = number
  # default     = 2
}

variable "max_capacity" {
  description = "Maximum number of nodes in the node group"
  type        = number
  # default     = 3
}

variable "min_capacity" {
  description = "Minimum number of nodes in the node group"
  type        = number
  # default     = 1
}
