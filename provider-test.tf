resource "azurerm_resource_group" "bino-provider-test-rg" {
  provider = azurerm.east
  name     = "bino-provider-example-rg-000"
  location = var.bino-region
}