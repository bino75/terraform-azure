# Connect to this vm using ssh -i id_rsa adminuser@bino-tf-lx-vm-public-dns-1.eastus2.cloudapp.azure.com -p22

resource "azurerm_public_ip" "bino-tf-lx-vm-public_ip" {
  name                = "bino-tf-lx-vm-ip-0"
  location            = azurerm_resource_group.bino-tf-cert-rg-000.location
  resource_group_name = azurerm_resource_group.bino-tf-cert-rg-000.name
  allocation_method   = "Static"
  domain_name_label   = "bino-tf-lx-vm-public-dns-1"
  tags                = var.bino-tags
}


resource "azurerm_network_interface" "bino-tf-cert-nic-001" {
  name                = "bino-tf-cert-nic-01"
  location            = azurerm_resource_group.bino-tf-cert-rg-000.location
  resource_group_name = azurerm_resource_group.bino-tf-cert-rg-000.name
  ip_configuration {
    name                          = "bino-tf-cert-subnet-000"
    subnet_id                     = azurerm_subnet.bino-tf-cert-subnet-000.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.bino-tf-lx-vm-public_ip.id
  }
  tags = var.bino-tags
}

resource "azurerm_network_security_group" "bino-tf-cert-nsg-000" {
  name                = "bino-tf-cert-nsg-000"
  location            = azurerm_resource_group.bino-tf-cert-rg-000.location
  resource_group_name = azurerm_resource_group.bino-tf-cert-rg-000.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "bino-tf-cert-nic-nsg-assoc-000" {
  network_interface_id      = azurerm_network_interface.bino-tf-cert-nic-001.id
  network_security_group_id = azurerm_network_security_group.bino-tf-cert-nsg-000.id
}

#Linux VM
resource "azurerm_linux_virtual_machine" "bino-tf-cert-linux-vm-000" {
  name                = "bino-tf-lx-vm-0"
  resource_group_name = azurerm_resource_group.bino-tf-cert-rg-000.name
  location            = azurerm_resource_group.bino-tf-cert-rg-000.location
  size                = local.vm-size
  admin_username      = local.admin_username
  network_interface_ids = [
    azurerm_network_interface.bino-tf-cert-nic-001.id,
  ]

  admin_ssh_key {
    username = local.admin_username
    #public_key = file("~/.ssh/id_rsa.pub")
    public_key = data.template_file.ssh_public_key.rendered
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  tags = var.bino-tags

  connection {
    type = "ssh"
    host = self.public_ip_address
    user = local.admin_username
    #private_key = file("${path.module}/id_rsa")
    private_key = file("id_rsa")
  }

  provisioner "file" {
    #content = "My file content"
    source      = "rg.txt"
    destination = "/home/adminuser/bino-rg-id.txt"
    on_failure  = continue
  }

  provisioner "remote-exec" {
    #when = destroy
    #script = ""
    on_failure = continue
    inline = [
      "touch /home/adminuser/bino-001.txt"
    ]
  }

}

data "template_file" "ssh_public_key" {
  template = file("${path.module}/id_rsa.pub")
}