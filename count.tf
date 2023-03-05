resource "azurerm_resource_group" "bino-count-test-rg" {
  count    = 2
  name     = "bino-count-example-rg-00${count.index}"
  location = var.bino-region
  tags = {
    "tag-key" = "tag-value-${count.index}"
  }
}

output "rg-tags-for-first-intance" {
  value = azurerm_resource_group.bino-count-test-rg[0].tags
}

output "rg-tags-for-all-intances" {
  value = azurerm_resource_group.bino-count-test-rg[*].tags
}

output "rg-tags-for-all-intances-using-for-loop" {
  value = [for rg in azurerm_resource_group.bino-count-test-rg : rg.tags]
}