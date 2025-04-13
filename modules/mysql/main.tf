resource "azurerm_mysql_flexible_server" "this" {
  name                   = "${var.name}${var.env}sql"
  resource_group_name    = var.resource_group_name
  location               = var.location
  administrator_login    = "${var.db_user_prefix}${var.env}user"
  administrator_password = random_password.password.result
  backup_retention_days  = 7
  private_dns_zone_id    = var.private_dns_zone_id
  sku_name               = var.sku_name
  zone                   = var.zone

  storage {
    auto_grow_enabled = var.storage.auto_grow_enabled
    iops              = var.storage.iops
    size_gb           = var.storage.size_gb
  }

  lifecycle {
    ignore_changes = [private_dns_zone_id]
  }

  depends_on = [azurerm_private_dns_zone_virtual_network_link.dns_virtual_link]
}

resource "azurerm_mysql_flexible_database" "this" {
  name                = var.db_name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_flexible_server.this.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}
