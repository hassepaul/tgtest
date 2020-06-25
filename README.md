## Requirements

The following requirements are needed by this module:

- terraform (>= 0.12.26)

- azurerm (~> 2.15.0)

## Providers

The following providers are used by this module:

- azurerm (~> 2.15.0)

## Required Inputs

The following input variables are required:

### availability\_zones

Description: zones where the nodes should be deployed

Type: `list(string)`

### dns\_prefix

Description: DNS prefix

Type: `string`

### dns\_service\_ip

Description: dns service ip

Type: `string`

### location

Description: azure location to deploy resources

Type: `string`

### max\_pods

Description: maximum number of pods that can run on a single node

Type: `number`

### node\_count

Description: number of nodes to deploy

Type: `string`

### resource\_group\_name

Description: name of the resource group to deploy AKS cluster in

Type: `string`

### service\_cidr

Description: kubernetes internal service cidr range

Type: `string`

### vm\_size

Description: size/type of VM to use for nodes

Type: `string`

### vnet\_subnet\_id

Description: vnet id where the nodes will be deployed

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### agent\_pool\_name

Description: name of node pool

Type: `string`

Default: `"default"`

### default\_tags

Description: standard tags

Type: `map(string)`

Default: `{}`

### docker\_bridge\_cidr

Description: docker bridge cidr

Type: `string`

Default: `"172.17.0.1/16"`

### load\_balancer\_type

Description: n/a

Type: `string`

Default: `"standard"`

### network\_plugin

Description: network plugin for kubenretes network overlay (azure or calico)

Type: `string`

Default: `"azure"`

### network\_policy

Description: n/a

Type: `string`

Default: `"azure"`

### prefix

Description: A naming prefix to be used in the creation of unique names for Azure resources.

Type: `list(string)`

Default: `[]`

### private\_cluster\_enabled

Description: true for private cluster

Type: `bool`

Default: `true`

### suffix

Description: A naming suffix to be used in the creation of unique names for Azure resources.

Type: `list(string)`

Default: `[]`

## Outputs

The following outputs are exported:

### azurerm\_kubernetes\_cluster\_fqdn

Description: n/a

### azurerm\_kubernetes\_cluster\_id

Description: n/a

### azurerm\_kubernetes\_cluster\_kube\_admin\_config

Description: n/a

### azurerm\_kubernetes\_cluster\_kube\_admin\_config\_raw

Description: n/a

### azurerm\_kubernetes\_cluster\_kube\_config

Description: n/a

### azurerm\_kubernetes\_cluster\_kube\_config\_raw

Description: n/a

### azurerm\_kubernetes\_cluster\_kubelet\_identity

Description: n/a

### azurerm\_kubernetes\_cluster\_node\_resource\_group

Description: n/a

### azurerm\_kubernetes\_cluster\_private\_fqdn

Description: n/a

