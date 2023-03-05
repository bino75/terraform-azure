data "azurerm_resource_group" "rg" {
  name = "bino-tf-cert-rg-000"
}

output "default-rg" {
  value = data.azurerm_resource_group.rg.id
}

/*data "azurerm_virtual_network" "vnet" {
  filter {
    name   = "tag:bino-tag"
    values = ["bino-upskill-tag", "bino-cert"]
  }
}*/

data "azurerm_virtual_network" "vnet" {
  name                = "bino-tf-cert-vnet-000"
  resource_group_name = "bino-tf-cert-rg-000"
}


output "vnet" {
  value = data.azurerm_virtual_network.vnet.subnets
}