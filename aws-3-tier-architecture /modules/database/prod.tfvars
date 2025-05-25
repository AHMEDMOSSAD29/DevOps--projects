 
db_name_prefix = "prod-db"
db_identifier = "production-database"
db_name = "production_data"
db_username = "prodadmin"
db_password = "your_secure_production_password" # Replace with a strong, production-level password
db_port = 5432 # Example: Using PostgreSQL port
db_engine = "postgres"
db_engine_version = "15.3" # Example: A more recent PostgreSQL version
db_instance_class = "db.m5.large" # Choose a production-grade instance class
db_allocated_storage = 100 # Allocate more storage for production
db_storage_type = "gp2" # Or "io1" for higher IOPS if needed
db_multi_az = true # Enable Multi-AZ for production high availability
db_publicly_accessible = false # Ensure it's NOT publicly accessible in production
db_skip_final_snapshot = false # Strongly recommend keeping final snapshots in production
db_final_snapshot_identifier = "prod-db-final-snapshot-20250525" # Consider a dynamic way to generate this

db_ingress_cidr_blocks = [
  "10.1.0.0/16", # Example: CIDR block of your application servers in production
  "10.2.0.0/24", # Example: Another internal network segment
]
