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

resource "azurerm_private_dns_zone" "private_dns_zone" {
  name                = "privatelink.mysql.database.azure.com"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "dns_virtual_link" {
  name                  = "${var.application}-${var.env}-mysql-vnet-link"
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone.name
  virtual_network_id    = var.vnet_id
  resource_group_name   = var.resource_group_name
}