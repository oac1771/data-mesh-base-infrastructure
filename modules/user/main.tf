resource "aws_iam_user" "cicd_platform_user" {
  name          = var.name
  path          = var.path
  force_destroy = var.force_destroy
}

