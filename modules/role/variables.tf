variable "name" {
  description = "Name of the Role. Must be unique within the account."
  type        = string  
}

variable "assume_role_policy_identifiers" {
  description = "List of identifiers allowed to assume role"
  type        = list
}
variable "actions" {
  description = "List of actions for trust policy"
  type        = list
}

variable "principal_type" {
  description = "principal type"
  type        = string
}

variable "condition_test" {
  description = "The name of the IAM condition operator to evaluate"
  type        = string
  default     = ""
}

variable "condition_variable" {
  description = "The name of a Context Variable to apply the condition to"
  type        = string
  default     = ""
}

variable "condition_values" {
  description = "The values to evaluate the condition against"
  type        = list
  default     = []
}
