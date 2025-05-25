# vpc variables
variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

# public subnet variables
 
variable "public_subnet_cidr" {
  type        = string
  description = "CIDR block for the public subnet"
  default     = "10.0.1.0/24"
}

variable "public_subnet_az" {
  type        = string
  description = "Availability zone for the public subnet"
  default     = "us-east-1a"
}
# private subnet variables
 
variable "private_subnet_cidr" {
  type        = string
  description = "CIDR block for the private subnet"
  default     = "10.0.2.0/24"
}

variable "private_subnet_az" {
  type        = string
  description = "Availability zone for the private subnet"
  default     = "us-east-1b"
}

# public route variables
 
variable "public_route_cidr" {
  type        = string
  description = "CIDR block for the default route in the public route table"
  default     = "0.0.0.0/0"
}

variable "public_route_name" {
  type        = string
  description = "Name tag for the public route table"
  default     = "public-route-table"
}

# private route variables
 
variable "private_route_cidr" {
  type        = string
  description = "CIDR block for the default route in the private route table"
  default     = "0.0.0.0/0"
}

variable "private_route_name" {
  type        = string
  description = "Name tag for the private route table"
  default     = "private-route-table"
}
 