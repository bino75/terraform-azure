resource "azurerm_subnet" "bino-tf-cert-subnet-001" {
  name                = "bino-tf-cert-subnet-001"
  resource_group_name = var.resource_group_name
  #virtual_network_name = azurerm_virtual_network.bino-tf-cert-vnet-000.name
  virtual_network_name = var.vnet-name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "bino-tf-cert-nic-001" {
  name                = "bino-tf-cert-nic-01"
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_configuration {
    name                          = azurerm_subnet.bino-tf-cert-subnet-001.name
    subnet_id                     = azurerm_subnet.bino-tf-cert-subnet-001.id
    private_ip_address_allocation = "Dynamic"
    #public_ip_address_id          = azurerm_public_ip.bino-tf-lx-vm-public_ip.id
    gateway_load_balancer_frontend_ip_configuration_id = azurerm_lb.bino-tf-cert-lb.frontend_ip_configuration[0].id
  }
  tags = var.tags
}

#Linux VM
resource "azurerm_linux_virtual_machine" "bino-tf-cert-linux-vm" {
  name                = var.vm-name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm-size
  admin_username      = var.admin_username
  network_interface_ids = [
    azurerm_network_interface.bino-tf-cert-nic-001.id,
  ]

  admin_ssh_key {
    username = var.admin_username
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

  tags = var.tags
}

data "template_file" "ssh_public_key" {
  template = file("${path.module}/id_rsa.pub")
}

resource "azurerm_public_ip" "bino-tf-lx-vm-public_ip" {
  name                = "bino-tf-lx-vm-ip-0"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  domain_name_label   = "bino-tf-lx-vm-public-dns-1"
  tags                = var.tags
}

resource "azurerm_lb" "bino-tf-cert-lb" {
  name                = "bino-tf-cert-lb"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.bino-tf-lx-vm-public_ip.id
  }
}

resource "azurerm_lb_backend_address_pool" "bino-tf-cert-bk-address-pool-000" {
  loadbalancer_id = azurerm_lb.bino-tf-cert-lb.id
  name            = "bino-tf-cert-bk-address-pool-000"
}

