output "vm_id" {
  description = "ID of the Linux Virtual Machine"
  value       = azurerm_linux_virtual_machine.this.id
}

output "vm_name" {
  description = "Name of the Linux Virtual Machine"
  value       = azurerm_linux_virtual_machine.this.name
}

output "nic_id" {
  description = "ID of the Network Interface"
  value       = azurerm_network_interface.this.id
}

output "private_ip_address" {
  description = "Private IP address assigned to the VM NIC"
  value       = azurerm_network_interface.this.private_ip_address
}