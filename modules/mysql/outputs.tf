output "server_name" {
  value = azurerm_mysql_flexible_server.this.name
}

output "admin_username" {
  value = azurerm_mysql_flexible_server.this.administrator_login
}

output "admin_creds" {
  value = azurerm_key_vault_secret.this.name
}