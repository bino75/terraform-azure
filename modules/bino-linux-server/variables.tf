variable "vnet-name" {
  type        = string
  description = "VNET Name"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "location" {
  type        = string
  description = "Location"
  default     = "eastus2"
}

variable "vm-name" {
  type        = string
  description = "Virtual Machine Name"
}

variable "vm-size" {
  type        = string
  default     = "Standard_F2"
  description = "VM Size"
}

variable "admin_username" {
  type        = string
  default     = "adminuser"
  description = "VM Admin UserName"
}

variable "tags" {
  type = object({
    org         = string
    cost-center = string
    dept-number = number
    }
  )
  description = "Tags"
}