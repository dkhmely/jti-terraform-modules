variable "name" {
  type        = string
  description = "Base name for the MySQL server"
}

variable "env" {
  type        = string
  description = "Environment name"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group for the MySQL server"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "db_user_prefix" {
  type        = string
  description = "Prefix for DB admin user"
}

variable "db_name" {
  type        = string
  description = "Name of the MySQL database"
}

variable "key_vault_id" {
  type        = string
  description = "ID of the Key Vault to store password"
}

variable "vnet_id" {
  type        = string
  description = "ID of the vnet"
}

variable "private_dns_zone_id" {
  type        = string
  description = "Private DNS zone ID for MySQL"
}

variable "dns_virtual_link_depends_on" {
  description = "Dependency placeholder for DNS virtual network link"
  type        = list(any)
  default     = []
}

variable "sku_name" {
  type        = string
  default     = "B_Standard_B1ms"
}

variable "zone" {
  type        = number
  default     = 2
}

variable "password_length" {
  type        = number
  default     = 16
}

variable "override_special_chars" {
  type        = string
  default     = "!#$%&*()-_=+[]{}<>:?"
}

variable "storage" {
  description = "Storage configuration for the MySQL server"
  type = object({
    auto_grow_enabled = bool
    iops              = number
    size_gb           = number
  })
  default = {
    auto_grow_enabled = true
    iops              = 360
    size_gb           = 20
  }
}

variable "private_endpoint_subnet_id" {
  description = "Subnet ID for the MySQL private endpoint"
  type        = string
}

variable "dns_zone_name" {
  description = "Name of the private DNS zone"
  type        = string
}