resource "aws_dynamodb_table" "table" {
  name     = var.name
  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  billing_mode = var.billing_mode
}
