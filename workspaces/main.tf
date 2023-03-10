locals {
  resource_group_name = "${terraform.workspace}-workspace-test-rg-000"
}

resource "azurerm_resource_group" "bino-workspace-test-rg" {
  name     = local.resource_group_name
  location = var.location
}