variable "name" {
  description = "Name of the policy. Must be unique."
  type        = string
}

variable "path" {
  description = "The Policy Path in AWS"
  type        = string
  default = "/datamesh/"
}

variable "description" {
  description = "The Policy Description"
  type        = string
}

variable "policy_file_path" {
  description = "The Policy File Path"
  type        = string
}