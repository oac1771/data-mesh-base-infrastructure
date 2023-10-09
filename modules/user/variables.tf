variable "name" {
  description = "Name of the IAM user. Must be unique."
  type        = string
}

variable "path" {
  description = "The User Path in AWS"
  type        = string
  default = "/datamesh/"
}

variable "force_destroy" {
  description = "Destroy even if it has non-Terraform-managed IAM access keys, login profile or MFA devices"
  type        = bool
  default = true
}

