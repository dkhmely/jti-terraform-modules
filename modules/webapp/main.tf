resource "azurerm_service_plan" "this" {
  name                = "${var.name}-serviceplan"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = var.sku_name
}

resource "azurerm_linux_web_app" "this" {
  name                = "${var.name}-app"
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.this.id

  identity {
    type = "SystemAssigned"
  }

  dynamic "site_config" {
    for_each = length(keys(var.site_config)) > 0 ? [1] : []
    content {
      container_registry_use_managed_identity = lookup(var.site_config, "container_registry_use_managed_identity", false)
      use_32_bit_worker                       = lookup(var.site_config, "use_32_bit_worker", true)
      always_on                               = lookup(var.site_config, "always_on", false)
    }
  }

  app_settings = {
    "DB_HOST" = var.db_host
    "DB_USER" = var.db_user
    "DB_PASS" = "@Microsoft.KeyVault(SecretUri=${var.db_password_secret_uri})"
    "DB_NAME" = var.db_name
    "DB_PORT" = var.db_port
  }
}
