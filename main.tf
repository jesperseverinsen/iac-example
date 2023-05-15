terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

resource "azurerm_resource_group" "iac-example" {
  name     = "iac-example-rg"
  location = "West Europe"
}

data "azurerm_key_vault" "iac-example" {
  name                = "iac-example-kv"
  resource_group_name = "iac-example"
}

data "azurerm_key_vault_secret" "vm_admin_name" {
  name         = "vm_admin_name"
  key_vault_id = data.azurerm_key_vault.existing.id
}

data "azurerm_key_vault_secret" "vm_admin_password" {
  name         = "vm_admin_password"
  key_vault_id = data.azurerm_key_vault.iac-example.id
}