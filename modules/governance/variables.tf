variable "resource_group_id" {
  description = "Resource Group ID where governance policies will be assigned"
  type        = string
}

variable "required_tags" {
  description = "Tags that must exist on Azure resources"
  type        = set(string)
}

variable "enforce_policy" {
  description = "Whether Azure Policy deny enforcement is enabled"
  type        = bool
  default     = false
}