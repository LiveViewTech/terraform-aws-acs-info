variable "vpc_type" {
  type        = string
  default     = "non-edge"
  description = "Retrieve VPC info for the corresponding VPC type. (defaults to non-edge)."

  validation {
    condition     = contains(["non-edge", "edge", "operations"], var.vpc_type)
    error_message = "Valid values for var: vpc_type are (null, edge, operations)."
  }
}

variable "profile" {
  type        = string
  default     = null
  description = "Terraform provider profile if default is not being used"
}
