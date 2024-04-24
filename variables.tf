variable "resource_group_name" {
    type = string
    description = "resource group name"
    default = "my-rg"
}

variable "resource_group_location" {
  type = string
  default = "Central India"
}

variable "number_of_vm" {
  type = number
  default = 2
}