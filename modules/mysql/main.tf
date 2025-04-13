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

}

resource "azurerm_mysql_flexible_database" "this" {
  name                = var.db_name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_flexible_server.this.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

resource "azurerm_private_endpoint" "this" {
  name                = "${var.name}-${var.env}-mysql-pep"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "${var.name}-${var.env}-mysql-psc"
    private_connection_resource_id = azurerm_mysql_flexible_server.this.id
    is_manual_connection           = false
    subresource_names              = ["mysqlServer"]
  }
}

resource "azurerm_private_dns_a_record" "this" {
  name                = "${var.name}${var.env}sql"
  zone_name           = var.dns_zone_name
  resource_group_name = var.resource_group_name
  ttl                 = 10
  records             = [azurerm_private_endpoint.this.private_service_connection[0].private_ip_address]
}

