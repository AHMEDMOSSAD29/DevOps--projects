output "cluster_name" {
  description = "Name of the EKS cluster"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "EKS cluster endpoint"
  value       = module.eks.cluster_endpoint
}

# output "cluster_certificate_authority" {
#   description = "EKS cluster certificate authority data"
#   value       = module.eks.cluster_certificate_authority
# }

# output "vpc_id" {
#   description = "VPC ID created for EKS"
#   value       = module.eks.vpc_id
# }

# output "public_subnet_ids" {
#   description = "Public subnet IDs"
#   value       = module.eks.public_subnet_ids
# }

# output "private_subnet_ids" {
#   description = "Private subnet IDs"
#   value       = module.eks.private_subnet_ids
# }

# output "node_group_arn" {
#   description = "ARN of the EKS node group"
#   value       = module.eks.node_group_arn
# }
