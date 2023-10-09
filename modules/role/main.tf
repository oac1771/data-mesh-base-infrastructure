data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = var.actions

    principals {
      type        = var.principal_type
      identifiers = var.assume_role_policy_identifiers
    }

    condition {
      test     = var.condition_test
      variable = var.condition_variable
      values   = var.condition_values
    }
  }
}

resource "aws_iam_role" "role" {
  name                 = var.name
  assume_role_policy   = data.aws_iam_policy_document.assume_role_policy.json
}
