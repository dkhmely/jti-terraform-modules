resource "random_password" "password" {
  length           = var.password_length
  special          = true
  override_special = var.override_special_chars
}

resource "azurerm_key_vault_secret" "this" {
  name         = "app-sql-user-password"
  value        = random_password.password.result
  key_vault_id = var.key_vault_id
}
