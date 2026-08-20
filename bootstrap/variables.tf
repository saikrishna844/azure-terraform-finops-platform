variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "location" {
  description = "Azure region for Terraform backend resources"
  type        = string
  default     = "centralindia"
}

variable "owner" {
  description = "Owner of the Terraform backend"
  type        = string
}

variable "cost_center" {
  description = "Cost center for FinOps tracking"
  type        = string
}

variable "required_tags" {
  description = "Mandatory resource tags for governance"

  type = set(string)

  default = [
    "Environment",
    "Project",
    "Owner",
    "CostCenter",
    "ManagedBy"
  ]
}

variable "enforce_tag_policy" {
  description = "Enable Azure Policy enforcement for mandatory tags"
  type        = bool
  default     = false
}

variable "ssh_public_key_path" {
  description = "Local path to the SSH public key used for DEV VMs"
  type        = string
}