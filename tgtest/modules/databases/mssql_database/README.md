## Requirements

No requirements.

## Providers

The following providers are used by this module:

- azurerm

## Required Inputs

The following input variables are required:

### location

Description: Storage account location

Type: `string`

### resource\_group\_name

Description: SQL server resource group

Type: `string`

### sql\_server\_id

Description: MSSQL Server ID

Type: `string`

### suffix

Description: naming suffix

Type: `list(string)`

## Optional Inputs

The following input variables are optional (have default values):

### collation

Description: Collation of the DB server

Type: `string`

Default: `"SQL_Latin1_General_CP1_CI_AS"`

### read\_scale

Description: If enabled, connections that have application intent set to readonly in their connection string may be routed to a readonly secondary replica

Type: `bool`

Default: `true`

### sku\_name

Description: The SKU name for this MySQL server.

Type: `string`

Default: `"BC_Gen5_2"`

### storage\_mb

Description: The maximum allowed storage capacity for MySQL server.

Type: `number`

Default: `5120`

### tags

Description: Tags to apply to all resources created.

Type: `map(string)`

Default: `{}`

### tier

Description: Storage tier - NOTE: Audit Policy only supports Standard

Type: `string`

Default: `"Standard"`

## Outputs

The following outputs are exported:

### azurerm\_mssql\_database\_id

Description: n/a

