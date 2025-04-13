
resource "azurerm_app_service_virtual_network_swift_connection" "this" {
  count          = var.vnet_integration && var.subnet_id != null ? 1 : 0
  app_service_id = azurerm_linux_web_app.this.id
  subnet_id      = var.subnet_id
}