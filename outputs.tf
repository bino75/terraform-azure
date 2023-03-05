output "bino-vnet" {
  value       = azurerm_virtual_network.bino-tf-cert-vnet-000
  description = "Outputs everything from the vnet"
  sensitive   = false
}

output "vm_ip" {
  value = azurerm_windows_virtual_machine.bino-tf-cert-vm-000.public_ip_address
}