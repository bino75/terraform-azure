resource "azurerm_resource_group" "bino-tf-cert-rg-000" {
  name     = "bino-tf-cert-rg-000"
  location = var.bino-region
  tags     = var.bino-tags
}

resource "azurerm_virtual_network" "bino-tf-cert-vnet-000" {
  name                = "bino-tf-cert-vnet-000"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.bino-tf-cert-rg-000.location
  resource_group_name = azurerm_resource_group.bino-tf-cert-rg-000.name
  tags                = var.bino-tags
}