variable "aws_region" {
  type        = string
  description = "The AWS region where you want to create your infrastructure. E.g: eu-west-1"
}

variable "bucket_name" {
  type        = string
}

variable "dynamo_table_name" {
  type        = string
}
