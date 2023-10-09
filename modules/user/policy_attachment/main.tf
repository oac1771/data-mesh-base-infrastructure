resource "aws_iam_user_policy_attachment" "policy_attachment" {
  user       = var.name
  policy_arn = var.policy_arn
}
