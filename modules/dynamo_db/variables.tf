variable "name" {
  description = "Name of the Dynamo DB Table. Must be unique in Region."
  type = string
}

variable "billing_mode" {
  description = "Desired Billing Mode."
  type = string
  default = "PAY_PER_REQUEST"
}