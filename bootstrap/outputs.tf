output "backend_resource_group_name" {
  description = "Resource Group containing Terraform remote state"
  value       = azurerm_resource_group.tfstate.name
}

output "storage_account_name" {
  description = "Storage Account containing Terraform state"
  value       = azurerm_storage_account.tfstate.name
}

output "container_name" {
  description = "Terraform state Blob container"
  value       = azurerm_storage_container.tfstate.name
}