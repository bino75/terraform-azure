resource "azurerm_resource_group" "bino-for-each-test-rg" {
  for_each = {
    dev  = "development"
    prod = "production"
  }
  name     = "bino-for-each-example-${each.value}-rg-000"
  location = var.bino-region
  tags = {
    "tag-key" = "tag-value-${each.key}-${each.value}-000"
  }
}

output "all-vms" {
  value = azurerm_resource_group.bino-for-each-test-rg[*]
}

output "prod-vm" {
  value = azurerm_resource_group.bino-for-each-test-rg["prod"]
}