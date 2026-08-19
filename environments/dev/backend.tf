terraform {
  backend "azurerm" {
    storage_account_name = "stfinopstfpc2qx0"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"

    use_azuread_auth = true
    use_cli          = true
  }
}

