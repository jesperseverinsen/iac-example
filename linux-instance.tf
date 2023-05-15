resource "azurerm_network_interface" "iac-example" {
  name                = "iac-example-nic"
  location            = azurerm_resource_group.iac-example.location
  resource_group_name = azurerm_resource_group.iac-example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.iac-example.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.iac-example.id
  }
}

resource "azurerm_linux_virtual_machine" "iac-example" {
  name                = "iac-example-machine01"
  resource_group_name = azurerm_resource_group.iac-example.name
  location            = azurerm_resource_group.iac-example.location
  size                = var.vm_size
  admin_username      = data.azurerm_key_vault_secret.vm_admin_name
  admin_password      = data.azurerm_key_vault_secret.vm_admin_password
  network_interface_ids = [
    azurerm_network_interface.iac-example.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "20.04-LTS"
    version   = "latest"
  }
}