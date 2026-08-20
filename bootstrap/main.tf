data "azurerm_client_config" "current" {}

resource "random_string" "storage_suffix" {
  length  = 6
  upper   = false
  special = false
}

resource "azurerm_resource_group" "tfstate" {
  name     = "rg-tfstate-finops-001"
  location = var.location

  tags = {
    Environment = "shared"
    Project     = "terraform-finops"
    Owner       = var.owner
    CostCenter  = var.cost_center
    ManagedBy   = "Terraform"
    Purpose     = "Terraform-Remote-State"
  }
}

resource "azurerm_storage_account" "tfstate" {

  #checkov:skip=CKV_AZURE_59:Public network access is required for GitHub-hosted runners in this lab. Access is protected with Microsoft Entra ID, RBAC, and OIDC. Production would use private endpoints/self-hosted runners.
  #checkov:skip=CKV_AZURE_206:LRS is intentionally used for this cost-conscious DEV/portfolio environment. Production Terraform state would use GRS/GZRS based on resilience requirements.
  #checkov:skip=CKV_AZURE_33:Azure Queue service is not used by this Terraform remote-state backend; state is stored in a private Blob container.


  name = "stfinopstf${random_string.storage_suffix.result}"

  resource_group_name = azurerm_resource_group.tfstate.name
  location            = azurerm_resource_group.tfstate.location

  account_tier             = "Standard"
  account_replication_type = "LRS"

  min_tls_version                 = "TLS1_2"
  public_network_access_enabled   = true
  allow_nested_items_to_be_public = false

  tags = {
    Environment = "shared"
    Project     = "terraform-finops"
    Owner       = var.owner
    CostCenter  = var.cost_center
    ManagedBy   = "Terraform"
    Purpose     = "Terraform-Remote-State"
  }
}

resource "azurerm_storage_container" "tfstate" {
  name = "tfstate"

  storage_account_id    = azurerm_storage_account.tfstate.id
  container_access_type = "private"
}

resource "azurerm_role_assignment" "terraform_state_access" {
  scope                = azurerm_storage_account.tfstate.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_ssh_public_key" "finops" {
  name                = "sshkey-terraform-finops-dev-001"
  resource_group_name = azurerm_resource_group.tfstate.name
  location            = azurerm_resource_group.tfstate.location

  public_key = file(pathexpand(var.ssh_public_key_path))

  tags = {
    Environment = "shared"
    Project     = "terraform-finops"
    Owner       = var.owner
    CostCenter  = var.cost_center
    ManagedBy   = "Terraform"
    Purpose     = "VM-Authentication"
  }
}