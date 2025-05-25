variable "vpc_id" {
  type        = string
  description = "ID of the VPC where the RDS instance will be created."
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of IDs of the private subnets for the RDS instance."
}

variable "db_name_prefix" {
  type        = string
  description = "Prefix for database related resource names."
  default     = "mydb"
}

variable "db_identifier" {
  type        = string
  description = "The unique identifier for the RDS instance."
  default     = "mydbinstance"
}

variable "db_name" {
  type        = string
  description = "The initial database name to create."
  default     = "mydatabase"
}

variable "db_username" {
  type        = string
  description = "The master username for the RDS instance."
  default     = "admin"
}

variable "db_password" {
  type        = string
  description = "The master password for the RDS instance."
  sensitive   = true
  default     = "admin"
}

variable "db_port" {
  type        = number
  description = "The port the database listens on."
  default     = 3306 # MySQL default
}

variable "db_engine" {
  type        = string
  description = "The database engine type (e.g., mysql, postgres, mariadb)."
  default     = "mysql"
}

variable "db_engine_version" {
  type        = string
  description = "The version of the database engine."
  default     = "5.7"
}

variable "db_instance_class" {
  type        = string
  description = "The instance type for the RDS instance."
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  type        = number
  description = "The allocated storage size for the RDS instance (in GB)."
  default     = 20
}

variable "db_storage_type" {
  type        = string
  description = "The storage type for the RDS instance (e.g., gp2, io1)."
  default     = "gp2"
}

variable "db_multi_az" {
  type        = bool
  description = "Enable Multi-AZ deployment for the RDS instance."
  default     = false
}

variable "db_publicly_accessible" {
  type        = bool
  description = "Whether the RDS instance is publicly accessible."
  default     = false
}

variable "db_skip_final_snapshot" {
  type        = bool
  description = "Whether to skip the final snapshot before deleting the RDS instance."
  default     = true
}

variable "db_final_snapshot_identifier" {
  type        = string
  description = "The identifier for the final snapshot when deleting the RDS instance."
  default     = null
}

variable "db_ingress_cidr_blocks" {
  type        = list(string)
  description = "List of CIDR blocks allowed to access the database."
  default     = ["10.0.0.0/8"] # Adjust this based on your network CIDR
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to apply to all resources in this module."
  default     = {}
}