resource "azurerm_virtual_network" "iac-example" {
  name                = "iac-example-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.iac-example.location
  resource_group_name = azurerm_resource_group.iac-example.name
}

resource "azurerm_subnet" "iac-example" {
  name                 = "iac-subnet"
  resource_group_name  = azurerm_resource_group.iac-example.name
  virtual_network_name = azurerm_virtual_network.iac-example.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "iac-example" {
  name                = "iac-example-machine01-pip"
  resource_group_name = azurerm_resource_group.iac-example.name
  location            = azurerm_resource_group.iac-example.location
  allocation_method   = "Static"
}