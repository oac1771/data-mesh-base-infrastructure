provider "aws" {
  region = var.aws_region
}

data "aws_caller_identity" "current" {}

################################################################################
# Create Terraform Backend
################################################################################

module "s3_bucket" {
  source      = "../../modules/s3_bucket"
  bucket_name = var.bucket_name
}

module "s3_bucket_policy" {
  source           = "../../modules/s3_bucket/policy"
  bucket_name      = var.bucket_name
  policy_file_path = "../../policy_files/s3_policy.json"
}

module "terraform_state_table" {
  source = "../../modules/dynamo_db"
  name   = var.dynamo_table_name
}
