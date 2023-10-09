module "efs" {
  source = "terraform-aws-modules/efs/aws"

  name                 = var.efs_name
  encrypted            = var.encrypted
  create_backup_policy = var.create_backup_policy
  enable_backup_policy = var.enable_backup_policy

  throughput_mode      = var.throughput_mode

  lifecycle_policy = {
    transition_to_ia = "AFTER_30_DAYS"
  }
  
  mount_targets = { for k, v in zipmap(slice(var.aws_availability_zone_names, 0, 3), var.private_subnets) : k => { subnet_id = v } }

  security_group_vpc_id      = var.vpc_id
  security_group_rules       = {
    vpc = {
      description = "NFS ingress from VPC private subnets"
      cidr_blocks = var.private_subnets_cidr_blocks
    }
  }

  attach_policy = true
  policy_statements = [
    {
      sid     = "EfsCustomPolicy"
      actions = ["elasticfilesystem:Client*"]
      effect = "Allow"
      principals = [
        {
          type        = "AWS"
          identifiers = ["*"]
        }
      ]
      conditions = [
        {
          test     = "Bool"
          variable = "elasticfilesystem:AccessedViaMountTarget"
          values = ["true"]
        }
      ]
    }
  ]

}