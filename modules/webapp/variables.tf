variable "name" {
  description = "Base name (prefix) of the app"
  type        = string
}

variable "location" {
  description = "Azure location"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "sku_name" {
  description = "SKU size for the service plan"
  type        = string
  default     = "B1"
}

variable "db_host" {
  description = "Database host"
  type        = string
}

variable "db_user" {
  description = "Database username"
  type        = string
}

variable "db_password_secret_uri" {
  description = "Key Vault Secret URI for DB password"
  type        = string
}

variable "db_name" {
  description = "Database name"
  type        = string
}

variable "db_port" {
  description = "Database port"
  type        = number
  default     = 3306
}

variable "subnet_id" {
  description = "Subnet ID for VNet integration"
  type        = string
  default     = null
}

variable "site_config" {
  description = "Optional site_config block for the app service"
  type        = any
  default     = {}
}

variable "acr_id" {
  description = "ACR id"
  type        = string
  default     = null
}

variable "key_vault_id" {
  description = "Key vault id"
  type        = string
  default     = null
}