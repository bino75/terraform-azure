variable "bino-region" {
  type = string
  #default     = "eastus2"
  description = "My Azure Region"
}

variable "bino-tags" {
  type = object({
    bino-tag    = string
    cost-center = string
    dept-number = number
    }
  )
}

variable "bino-tags-list" {
  type = list(string)
}