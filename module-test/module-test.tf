
# Use data block to get the vnet?

module "bino-vm-server" {
  source              = "../modules/bino-linux-server"
  vnet-name           = "bino-tf-cert-vnet-000"
  resource_group_name = "bino-tf-cert-rg-000"
  vm-name             = "bino-lx-vm-12"
  tags = {
    cost-center = "bino"
    dept-number = 1
    org         = "BBM"
  }
}

/*output "vm_instance" {
  value = module.bino-vm-server.linux-server-instance
}*/

/*resource "" "name" {
 var ok = module.bino-vm-server.linux-server-instance.id
}*/