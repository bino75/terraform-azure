terraform {
  required_version = ">= 1.3.9"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.1"
    }
  }
}

provider "azurerm" {
  #alias     = "east"
  tenant_id = "4340cf72-abda-4412-909e-8acf9751d21a"
  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}