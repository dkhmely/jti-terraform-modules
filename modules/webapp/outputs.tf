output "app_name" {
  value = azurerm_linux_web_app.this.name
}

output "app_identity" {
  value = azurerm_linux_web_app.this.identity[0].principal_id
}

output "default_hostname" {
  value = azurerm_linux_web_app.this.default_hostname
}