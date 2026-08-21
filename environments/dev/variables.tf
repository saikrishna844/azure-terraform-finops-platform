variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "centralindia"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "terraform-finops"
}

variable "owner" {
  description = "Owner of the infrastructure"
  type        = string
}

variable "cost_center" {
  description = "Cost center used for FinOps tracking"
  type        = string
}

variable "vnet_address_space" {
  description = "Address space for the DEV Virtual Network"
  type        = list(string)
}

variable "app_subnet_prefixes" {
  description = "Address prefixes for the DEV application subnet"
  type        = list(string)
}

variable "management_subnet_prefixes" {
  description = "Address prefixes for the DEV management subnet"
  type        = list(string)
}

variable "vm_size" {
  description = "Size of the DEV Linux VM"
  type        = string
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "Administrator username for the DEV Linux VM"
  type        = string
  default     = "azureadmin"
}

variable "ssh_public_key_path" {
  description = "Path to the SSH public key"
  type        = string
}
variable "cpu_alert_threshold" {
  description = "CPU percentage threshold for the DEV VM alert"
  type        = number
  default     = 80
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

variable "service_name" {
  description = "Service name for the infrastructure"
  type        = string
}

