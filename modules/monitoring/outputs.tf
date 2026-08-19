output "log_analytics_workspace_id" {
  description = "ID of the Log Analytics Workspace"
  value       = azurerm_log_analytics_workspace.this.id
}

output "log_analytics_workspace_name" {
  description = "Name of the Log Analytics Workspace"
  value       = azurerm_log_analytics_workspace.this.name
}

output "vm_diagnostic_setting_id" {
  description = "ID of the VM diagnostic setting"
  value       = azurerm_monitor_diagnostic_setting.vm.id
}

output "cpu_alert_id" {
  description = "ID of the VM high CPU alert"
  value       = azurerm_monitor_metric_alert.high_cpu.id
}