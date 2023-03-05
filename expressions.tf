resource "azurerm_resource_group" "bino-expression-test-rg" {
  provider = azurerm.east
  name     = "bino-expression-example-rg-000"
  location = var.bino-region
  tags = {
    #if-else
    bino-conditional-tag = local.vm-size == "Standard_F2" ? "Standard" : "Non-standard"

    #multi-line strings using heredoc block, EOT: end of text
    bino-muti-line-string = <<EOT
        bino's multiline tag
    EOT

    #multi-line strings, allows for indentation in heredoc blocks
    bino-muti-line-string = <<-EOT
        bino's multiline tag with no indentation with the "-"
    EOT

    #directive
    bino-test-if = "Hello, %{if local.admin_username != ""} ${local.admin_username}%{else}nouser %{endif}!"

    testing-loop = <<EOT
        %{for tag in var.bino-tags}
            my-tag = ${tag}
        %{endfor}
    EOT    
  }
}