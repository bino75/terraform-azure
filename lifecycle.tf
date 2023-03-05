resource "azurerm_resource_group" "bino-lifecycle-test-rg" {
  provider = azurerm.east
  name     = "bino-lifecycle-example-rg-000"
  location = var.bino-region

  lifecycle {
    #create_before_destroy = false
    prevent_destroy = false
    #ignore_changes = []
  }
}