module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.5.1"

  create_cloudwatch_log_group = false

  create_iam_role = var.create_iam_role

  cluster_name    = var.cluster_name
  cluster_version = "1.25"

  vpc_id                         = var.vpc_id
  subnet_ids                     = var.subnet_ids
  cluster_endpoint_public_access = true

  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"

  }

  eks_managed_node_groups = {
    one = {
      name = var.node_group_one_name

      instance_types = ["t3.large"]

      min_size        = 1
      max_size        = 2
      desired_size    = 1
      create_iam_role = var.create_iam_role
    }

    two = {
      name           = var.node_group_two_name
      instance_types = ["t3.large"]

      min_size        = 1
      max_size        = 2
      desired_size    = 1
      create_iam_role = var.create_iam_role
    }
  }
}
