variable "resource_group_name" {
    type = string
    description = "resource group name"
}

variable "resource_group_location" {
  type = string
  default = "Cental India"
}

variable "admin_username" {
  default = "adminuser"
}

variable "admin_password" {
  default = "P@$$w0rd1234!"
}

variable "number_of_vm" {
  type = number
}

variable "subnetid" {
  type = string
}