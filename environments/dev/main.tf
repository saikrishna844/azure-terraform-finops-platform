
module "resource_group" {
  source = "../../modules/resource-group"

  name     = "rg-${var.project_name}-${var.environment}-001"
  location = var.location

  tags = local.common_tags
}

module "networking" {
  source = "../../modules/networking"

  resource_group_name = module.resource_group.name
  location            = module.resource_group.location

  vnet_name          = "vnet-${var.project_name}-${var.environment}-001"
  vnet_address_space = var.vnet_address_space

  app_subnet_name     = "snet-app-${var.environment}-001"
  app_subnet_prefixes = var.app_subnet_prefixes

  management_subnet_name     = "snet-management-${var.environment}-001"
  management_subnet_prefixes = var.management_subnet_prefixes

  nsg_name = "nsg-${var.project_name}-${var.environment}-001"

  tags = local.common_tags
}


module "compute" {
  source = "../../modules/compute"

  resource_group_name = module.resource_group.name
  location            = var.location

  subnet_id = module.networking.app_subnet_id

  nic_name = "nic-${var.project_name}-${var.environment}-001"
  vm_name  = "vm-${var.project_name}-${var.environment}-001"

  vm_size        = var.vm_size
  admin_username = var.admin_username
  ssh_public_key = data.azurerm_ssh_public_key.vm.public_key

  tags = local.common_tags
}

module "monitoring" {
  source = "../../modules/monitoring"

  resource_group_name = module.resource_group.name
  location            = var.location

  vm_id = module.compute.vm_id

  workspace_name = "law-${var.project_name}-${var.environment}-001"

  diagnostic_setting_name = "diag-${var.project_name}-${var.environment}-vm-001"

  cpu_alert_name = "alert-${var.project_name}-${var.environment}-high-cpu-001"

  cpu_alert_threshold = var.cpu_alert_threshold

  tags = local.common_tags
}

module "governance" {
  source = "../../modules/governance"

  resource_group_id = module.resource_group.id

  required_tags = var.required_tags

  enforce_policy = var.enforce_tag_policy
}
data "azurerm_ssh_public_key" "vm" {
  name                = "sshkey-terraform-finops-dev-001"
  resource_group_name = "rg-tfstate-finops-001"
}