#
# Creates SQL Server with private endpoint only
#

## Requirements

The following requirements are needed by this module:

- terraform (>= 0.12.26)

- azurerm (>= 2.31.0)

## Providers

The following providers are used by this module:

- azurerm (>= 2.31.0)

## Required Inputs

The following input variables are required:

### location

Description: SQL server location

Type: `string`

### password

Description: SQL admin password

Type: `string`

### primary\_naming

Description: Naming for primary resources

Type: `list(string)`

### resource\_group\_name

Description: SQL server resource group

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### admin\_user

Description: SQL admin user

Type: `string`

Default: `"mssqladmin"`

### minimum\_tls

Description: (Optional) The Minimum TLS Version for all SQL Database and SQL Data Warehouse databases associated with the server. Valid values are: 1.0, 1.1 and 1.2.n

Type: `string`

Default: `"1.2"`

### private\_dns\_zone\_ids

Description: The private dns zones to use with the private endpoint.

Type: `list(string)`

Default: `[]`

### private\_dns\_zone\_ids\_secondary

Description: The private dns zones to use with the private endpoint.

Type: `list(string)`

Default: `[]`

### public\_network\_access\_enabled

Description: (Optional) Whether or not public network access is allowed for this server. Defaults to true.

Type: `bool`

Default: `false`

### read\_scale

Description: If enabled, connections that have application intent set to readonly in their connection string may be routed to a readonly secondary replica

Type: `bool`

Default: `true`

### retention\_days

Description: (Optional) Retention days of the audit

Type: `number`

Default: `90`

### sa\_replication\_type

Description: SA Replication type - defaults to LRS

Type: `string`

Default: `"LRS"`

### server\_version

Description: SQL server version

Type: `string`

Default: `"12.0"`

### sku\_name

Description: The SKU name for this MySQL server.

Type: `string`

Default: `"BC_Gen5_2"`

### subnet\_id

Description: The subnet id of the private endpoint.

Type: `string`

Default: `null`

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

### primary\_mssql\_server\_fqdn

Description: n/a

### server\_id

Description: n/a

### sql\_server\_name

Description: Name of the server created. Use this if more databases needs to be added to the server.

