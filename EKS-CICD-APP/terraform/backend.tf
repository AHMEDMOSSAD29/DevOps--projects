# backend.tf
terraform {
  backend "local" {
    # bucket  = "mosaad-terraform"
    # key     = "terraform.tfstate" # Path to store the state file
    # region  = "us-east-1"         # Same region as the bucket
    # encrypt = true
  }
}