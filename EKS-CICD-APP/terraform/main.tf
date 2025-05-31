  module "eks" {
  source = "./modules/eks"

  cluster_name              = var.cluster_name
  region                    = var.region
  vpc_cidr                  = var.vpc_cidr
  public_subnet_cidrs       = var.public_subnet_cidrs
  private_subnet_cidrs      = var.private_subnet_cidrs
  node_group_instance_types = var.node_group_instance_types
  desired_capacity          = var.desired_capacity
  max_capacity              = var.max_capacity
  min_capacity              = var.min_capacity
}

