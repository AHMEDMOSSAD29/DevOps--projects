output "cluster_name" {
  description = "Name of the EKS cluster"
  value       = aws_eks_cluster.eks_cluster.name
}

output "cluster_endpoint" {
  description = "Endpoint for the EKS cluster"
  value       = aws_eks_cluster.eks_cluster.endpoint
}

output "cluster_certificate_authority" {
  description = "Base64 encoded certificate authority data"
  value       = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}

output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.eks_vpc.id
}

output "public_subnet_ids" {
  description = "IDs of public subnets"
  value       = aws_subnet.public_subnets[*].id
}

output "private_subnet_ids" {
  description = "IDs of private subnets"
  value       = aws_subnet.private_subnets[*].id
}

output "node_group_arn" {
  description = "ARN of the EKS node group"
  value       = aws_eks_node_group.eks_nodes.arn
}
