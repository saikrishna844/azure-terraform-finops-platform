variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "vm_id" {
  description = "Resource ID of the Virtual Machine to monitor"
  type        = string
}

variable "workspace_name" {
  description = "Name of the Log Analytics Workspace"
  type        = string
}

variable "diagnostic_setting_name" {
  description = "Name of the VM diagnostic setting"
  type        = string
}

variable "cpu_alert_name" {
  description = "Name of the high CPU metric alert"
  type        = string
}

variable "cpu_alert_threshold" {
  description = "CPU percentage that triggers the alert"
  type        = number
  default     = 80
}

variable "tags" {
  description = "Tags applied to monitoring resources"
  type        = map(string)
  default     = {}
}