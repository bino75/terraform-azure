data "azurerm_virtual_network" "bino-vnet" {
  name                = "bino-tf-cert-vnet-000"
  resource_group_name = "bino-tf-cert-rg-000"
}

resource "azurerm_subnet" "bino-tf-cert-subnet-000" {
  name                = "bino-tf-cert-subnet-000"
  resource_group_name = azurerm_resource_group.bino-tf-cert-rg-000.name
  #virtual_network_name = azurerm_virtual_network.bino-tf-cert-vnet-000.name
  virtual_network_name = data.azurerm_virtual_network.bino-vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "bino-tf-cert-nic-000" {
  name                = "bino-tf-cert-nic-00"
  location            = azurerm_resource_group.bino-tf-cert-rg-000.location
  resource_group_name = azurerm_resource_group.bino-tf-cert-rg-000.name
  ip_configuration {
    name                          = "bino-tf-cert-subnet-000"
    subnet_id                     = azurerm_subnet.bino-tf-cert-subnet-000.id
    private_ip_address_allocation = "Dynamic"
  }
  tags = var.bino-tags
}

# Windows VM
resource "azurerm_windows_virtual_machine" "bino-tf-cert-vm-000" {
  name                = "bino-tf-vm-0"
  resource_group_name = azurerm_resource_group.bino-tf-cert-rg-000.name
  location            = azurerm_resource_group.bino-tf-cert-rg-000.location
  size                = local.vm-size
  admin_username      = local.admin_username
  admin_password      = local.admin_password
  network_interface_ids = [
    azurerm_network_interface.bino-tf-cert-nic-000.id,
  ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
  tags = var.bino-tags
}