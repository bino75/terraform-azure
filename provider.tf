provider "azurerm" {
  alias     = "east"
  tenant_id = "4340cf72-abda-4412-909e-8acf9751d21a"
  features {}
}

/*provider "azurerm" {
  alias = "west"
  location = "westus"
  tags {
    bino-region-tag    = "bino-west-region"
  }
}*/