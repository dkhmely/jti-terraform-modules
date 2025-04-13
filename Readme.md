# jti-terraform-modules

## Purpose

The `jti-terraform-modules` repository provides a collection of reusable, version-controlled **Terraform modules** that standardize infrastructure provisioning across JTI projects. These modules are designed to be consumed by infrastructure repositories such as `jti-infra`, ensuring consistency and modularity.

> Modules in this repository are managed using **tags** for version control. This enables clean feature releases and backward compatibility for downstream usage.

---

## Available Modules

This repository includes reusable modules for:

- **MySQL**
- **WebbApp**

Each module includes (by standard):
- `main.tf`: Core logic
- `variables.tf`: Input definitions
- `outputs.tf`: Module outputs

---

## Usage

These modules are consumed by referencing a tag in `source`:

```hcl
module "mysql" {
  source = "git::https://github.com/dkhmely/jti-terraform-modules.git//modules/mysql?ref=v1.0.12"

  name                       = var.application
  env                        = var.env
  location                   = data.azurerm_resource_group.rg.location
  resource_group_name        = data.azurerm_resource_group.rg.name
  db_user_prefix             = var.db_user_prefix
  db_name                    = var.application
  key_vault_id               = data.azurerm_key_vault.kv.id
  vnet_id                    = data.azurerm_virtual_network.vnet.id
  private_endpoint_subnet_id = azurerm_subnet.pep_subnet.id

}
```

Always reference specific tags to ensure stable and predictable deployments.
