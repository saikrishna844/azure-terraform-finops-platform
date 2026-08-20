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

  # --------------------------------------------------
  # Accepted Checkov findings for DEV/portfolio design
  # --------------------------------------------------

  #checkov:skip=CKV_AZURE_59:Public network connectivity is required for GitHub-hosted Actions runners. Data access is protected using Microsoft Entra ID, RBAC and OIDC. Production would use a private endpoint with a private/self-hosted runner.

  #checkov:skip=CKV2_AZURE_33:Private Endpoint intentionally omitted because GitHub-hosted runners require public network connectivity. Production architecture would use Private Link and a self-hosted runner inside Azure networking.

  #checkov:skip=CKV_AZURE_206:LRS is intentionally selected for this cost-conscious DEV FinOps environment. Production state storage would use GRS/GZRS according to business continuity requirements.

  #checkov:skip=CKV_AZURE_33:Azure Queue Storage is not used by this Terraform state backend, therefore Queue service logging is not enabled.

  #checkov:skip=CKV2_AZURE_21:Blob request logging is omitted in this DEV lab to avoid additional logging architecture and ingestion cost. Production would forward storage diagnostics to a dedicated monitoring/security workspace.

  #checkov:skip=CKV2_AZURE_1:Microsoft-managed encryption is accepted for this DEV portfolio environment. Production environments with regulatory requirements would use Customer Managed Keys.

  name = "stfinopstf${random_string.storage_suffix.result}"

  resource_group_name = azurerm_resource_group.tfstate.name
  location            = azurerm_resource_group.tfstate.location

  account_tier             = "Standard"
  account_replication_type = "LRS"

  min_tls_version                 = "TLS1_2"
  public_network_access_enabled   = true
  allow_nested_items_to_be_public = false

  # Disable Storage Account Shared Key authentication
  shared_access_key_enabled = false

  # Prefer Microsoft Entra authentication in Azure Portal
  default_to_oauth_authentication = true

  # Limit SAS token lifetime
  sas_policy {
    expiration_period = "01.00:00:00"
    expiration_action = "Log"
  }

  # Protect accidentally deleted Terraform state blobs
  blob_properties {
    delete_retention_policy {
      days = 7
    }

    container_delete_retention_policy {
      days = 7
    }
  }

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