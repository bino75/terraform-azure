resource "azurerm_resource_group" "bino-provisioner-test-rg" {
  provider = azurerm.east
  name     = "bino-provisioner-example-rg-000"
  location = var.bino-region

  # Only runs first time the resource is created or on the destroy. 
  provisioner "local-exec" {
    command = "echo ${self.id} > rg.txt"
  }
}