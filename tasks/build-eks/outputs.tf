output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.datamesh_eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane"
  value       = module.datamesh_eks.cluster_security_group_id
}

output "region" {
  description = "AWS region"
  value       = var.region
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = module.datamesh_eks.cluster_name
}

output "efs_id" {
  description = "The ID that identifies the file system (e.g., `fs-ccfc0d65`)"
  value       = module.datamesh_efs.id
}
