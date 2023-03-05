/*resource "azurerm_resource_group" "bino-dynamic-block-test-rg" {
  name     = "bino-dynamic-block-example-rg-000"
  location = var.bino-region

  dynamic "tags" {
    for_each = local.tags
    content {
      tag1 = tags.value.tag-key-1
    }
  }
}

locals {
  tags = [{
    tag-key-1 = "tag-value-1"
    },
    {
      tag-key-2 = "tag-value-2"
  }]
}*/