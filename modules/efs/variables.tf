variable "efs_name" {
  description = "Name of the efs service"
  type = string
}

variable "throughput_mode" {
  description = "Throughput mode for the file system. "
  type = string
}

variable "aws_availability_zone_names" {
  description = "Availability Zone Names"
  type        = list
}

variable "private_subnets" {
  description = "VPC private subnets"
  type        = list
}

variable "vpc_id" {
  description = "ID of VPC"
  type        = string
}

variable "private_subnets_cidr_blocks" {
  description = "VPC private subnet cidr blocks"
  type        = list
}

variable "encrypted" {
  description = "Controls if disk is encrypted"
  type = bool
  default = true
}

variable "create_backup_policy" {
  description = "Determines wheter a backup policy is created"
  type = bool
  default = false
}

variable "enable_backup_policy" {
  description = "Determines wheter a backup policy is enabled or disabled"
  type = bool
  default = false
}