variable "create_iam_role" {
  description = "Create the IAM Role associated with this EKS Cluster"
  type        = bool
}

variable "vpc_id" {
    description = "The VPC ID to attach to this EKS Cluster"
    type = string
}

variable "subnet_ids" {
  description = "The Subnet IDs to attach to this EKS Cluster"
  type = list
}

variable "cluster_name" {
  description = "The name of this EKS Cluster"
  type        = string
}

variable "node_group_one_name" {
  description = "The Name of the first Node Group"
  type        = string
}

variable "node_group_two_name" {
  description = "The Name of the second Node Group"
  type        = string
}
