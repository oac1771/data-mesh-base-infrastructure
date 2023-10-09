resource "aws_iam_policy" "iam_policy" {
  name        = var.name
  path        = var.path
  description = var.description

  policy = file(var.policy_file_path)
}
