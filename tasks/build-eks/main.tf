locals {
  cluster_name                   = "datamesh-accelerator-cluster"
  vpc_name                       = "datamesh-accelerator-vpc"
  efs_name                       = "datamesh-accelerator-efs"
  create_iam_role                = true
  node_group_one_name            = "one"
  node_group_two_name            = "two"
  k8s_aws_admin_role_name        = "k8s-platform-admin-role"
  k8s_aws_admin_role_identifiers = [
    "arn:aws:sts::182174426630:assumed-role/AWSReservedSSO_Admin-Account-Access_25c3b5389e87db89/omar.carey@thoughtworks.com",
    "arn:aws:sts::182174426630:assumed-role/AWSReservedSSO_Admin-Account-Access_25c3b5389e87db89/aslihan.ozmen@thoughtworks.com",
    "arn:aws:sts::182174426630:assumed-role/AWSReservedSSO_Admin-Account-Access_25c3b5389e87db89/aurelio.nogueira@thoughtworks.com",
    "arn:aws:sts::182174426630:assumed-role/AWSReservedSSO_Admin-Account-Access_25c3b5389e87db89/bryan.nice@thoughtworks.com",
    "arn:aws:sts::182174426630:assumed-role/AWSReservedSSO_Admin-Account-Access_25c3b5389e87db89/daniel.scarbrough@thoughtworks.com"
  ]
}

provider "aws" {
  region = var.region
}

data "aws_availability_zones" "available" {}

################################################################################
# Create VPC and EKS Resources
################################################################################

module "datamesh_vpc" {
  source                      = "../../modules/vpc"
  aws_availability_zone_names = data.aws_availability_zones.available.names
  cluster_name                = local.cluster_name
  name                        = local.vpc_name
}

module "datamesh_eks" {
  source              = "../../modules/eks"
  node_group_one_name = local.node_group_one_name
  node_group_two_name = local.node_group_two_name
  create_iam_role     = local.create_iam_role
  cluster_name        = local.cluster_name
  vpc_id              = module.datamesh_vpc.vpc_id
  subnet_ids          = module.datamesh_vpc.public_subnets
}

################################################################################
# Create K8s AWS Admin Role
################################################################################

module "k8s_aws_admin_role" {
  source                          = "../../modules/role"
  name                            = local.k8s_aws_admin_role_name
  assume_role_policy_identifiers  = ["182174426630"]
  actions                         = ["sts:AssumeRole"]
  principal_type                  = "AWS"
  condition_test                  = "StringLike"
  condition_variable              = "aws:userId"
  condition_values                = ["*@thoughtworks.com"]
}

################################################################################
# EFS CSI Driver k8 service account Policy and Role
################################################################################

module "efs_csi_driver_policy" {
  source           = "../../modules/user/policy"
  name             = "AmazonEKS_EFS_CSI_Driver_Policy"
  description      = "Allows csi drivers k8s service account to make calls to aws api"
  policy_file_path = "../../policy_files/aws_eks_efs_csi_driver_policy.json"
}

module "efs_csi_driver_role" {
  source                          = "../../modules/role"
  name                            = "AmazonEKS_EFS_CSI_DriverRole"
  assume_role_policy_identifiers  = [format("%s/%s", "arn:aws:iam::182174426630:oidc-provider", module.datamesh_eks.oidc_provider)]
  actions                         = ["sts:AssumeRoleWithWebIdentity"]
  principal_type                  = "Federated"
  condition_test                  = "StringEquals"
  condition_variable              = format("%s:sub", module.datamesh_eks.oidc_provider)
  condition_values                = ["system:serviceaccount:kube-system:efs-csi-controller-sa"]
}
resource "aws_iam_policy_attachment" "efs-csi-role-policy-attachment" {
  name       = "efs-csi-role-policy-attachment"
  roles      = [module.efs_csi_driver_role.role_name]
  policy_arn = module.efs_csi_driver_policy.iam_policy_arn
}

################################################################################
# EFS Resources
################################################################################

module "datamesh_efs" {
  source                      = "../../modules/efs"
  efs_name                    = local.efs_name
  throughput_mode             = "bursting"
  aws_availability_zone_names = data.aws_availability_zones.available.names
  private_subnets             = module.datamesh_vpc.private_subnets
  vpc_id                      = module.datamesh_vpc.vpc_id
  private_subnets_cidr_blocks = module.datamesh_vpc.private_subnets_cidr_blocks
}