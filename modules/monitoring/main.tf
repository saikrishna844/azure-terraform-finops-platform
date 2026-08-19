resource "azurerm_log_analytics_workspace" "this" {
  name                = var.workspace_name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku               = "PerGB2018"
  retention_in_days = 30

  tags = var.tags
}

resource "azurerm_monitor_diagnostic_setting" "vm" {
  name               = var.diagnostic_setting_name
  target_resource_id = var.vm_id

  log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id

  enabled_metric {
    category = "AllMetrics"
  }
}

resource "azurerm_monitor_metric_alert" "high_cpu" {
  name                = var.cpu_alert_name
  resource_group_name = var.resource_group_name

  scopes = [
    var.vm_id
  ]

  description = "Alert when VM average CPU usage exceeds the configured threshold."

  severity      = 2
  enabled       = true
  auto_mitigate = true

  frequency   = "PT5M"
  window_size = "PT5M"

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Percentage CPU"

    aggregation = "Average"
    operator    = "GreaterThan"
    threshold   = var.cpu_alert_threshold
  }

  tags = var.tags
}