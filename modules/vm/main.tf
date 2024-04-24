resource "azurerm_network_interface" "vnet" {
  name = "vm-nic-${count.index + 1}"
  location = var.resource_group_location
  resource_group_name = var.resource_group_name
  count = var.number_of_vm
  ip_configuration {
    name = "internal"
    subnet_id = var.subnetid
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.vnet[count.index].id

  }
}

resource "azurerm_network_interface_security_group_association" "vnet" {
  network_interface_id = azurerm_network_interface.vnet[count.index].id
  network_security_group_id = azurerm_network_security_group.vnet.id
  count = var.number_of_vm
}

resource "azurerm_windows_virtual_machine" "vnet" {
  count = var.number_of_vm
  name = "VM-${count.index + 1}"
  resource_group_name = var.resource_group_name
  location = var.resource_group_location
  size = "Standard_F2"
  admin_username = var.admin_username
  admin_password = var.admin_password
  network_interface_ids = [azurerm_network_interface.vnet[count.index].id,]
  os_disk {
    name = "osdisk-${count.index + 1}"
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  
}

resource "azurerm_public_ip" "vnet" {
  name = "vm-ip-${count.index + 1}"
  location = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method = "Static"
  count = var.number_of_vm
}

resource "azurerm_network_security_group" "vnet" {
  name = "nsg"
  location = var.resource_group_location
  resource_group_name = var.resource_group_name
  security_rule {
    name = "test123"
    priority = 100
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "*"
    source_address_prefix = "*"
    destination_address_prefix = "*"
  }
}