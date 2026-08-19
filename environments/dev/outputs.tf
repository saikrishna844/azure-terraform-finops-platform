output "resource_group_id" {
  description = "Azure Resource Group ID"
  value       = module.resource_group.id
}

output "resource_group_name" {
  description = "Azure Resource Group name"
  value       = module.resource_group.name
}

output "resource_group_location" {
  description = "Azure Resource Group location"
  value       = module.resource_group.location
}

output "vnet_id" {
  description = "DEV Virtual Network ID"
  value       = module.networking.vnet_id
}

output "vnet_name" {
  description = "DEV Virtual Network name"
  value       = module.networking.vnet_name
}

output "app_subnet_id" {
  description = "DEV application subnet ID"
  value       = module.networking.app_subnet_id
}

output "management_subnet_id" {
  description = "DEV management subnet ID"
  value       = module.networking.management_subnet_id
}

output "network_security_group_id" {
  description = "DEV Network Security Group ID"
  value       = module.networking.nsg_id
}

output "vm_id" {
  description = "DEV Linux VM ID"
  value       = module.compute.vm_id
}

output "vm_name" {
  description = "DEV Linux VM name"
  value       = module.compute.vm_name
}

output "vm_nic_id" {
  description = "DEV VM Network Interface ID"
  value       = module.compute.nic_id
}

output "vm_private_ip_address" {
  description = "DEV VM private IP address"
  value       = module.compute.private_ip_address
}

output "log_analytics_workspace_id" {
  description = "DEV Log Analytics Workspace ID"
  value       = module.monitoring.log_analytics_workspace_id
}

output "log_analytics_workspace_name" {
  description = "DEV Log Analytics Workspace name"
  value       = module.monitoring.log_analytics_workspace_name
}

output "cpu_alert_id" {
  description = "DEV VM high CPU alert ID"
  value       = module.monitoring.cpu_alert_id
}

output "required_tag_policy_assignment_ids" {
  description = "DEV mandatory tag policy assignment IDs"
  value       = module.governance.required_tag_policy_assignment_ids
}