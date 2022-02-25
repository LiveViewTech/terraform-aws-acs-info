variable "edge" {
  type        = bool
  default     = false
  description = "Retrieve VPC info for the VPC that has Edge Connectivity (defaults to false)."
}

variable "profile" {
  type        = string
  default     = "default"
  description = "Terraform provider profile if default is not being used"
}
