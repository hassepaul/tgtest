This module create a private AKS cluster with diagnostics (if set)

## Requirements

The following requirements are needed by this module:

- terraform (>= 0.12.26)

- azurerm (>= 2.31.0)

- azurerm (2.31.0)

## Providers

The following providers are used by this module:

- azurerm (>= 2.31.0 2.31.0)

## Required Inputs

The following input variables are required:

### dns\_prefix

Description:  (Required) DNS prefix specified when creating the managed cluster. Changing this forces a new resource to be created.

Type: `string`

### location

Description: (Required) The location where the Managed Kubernetes Cluster should be created. Changing this forces a new resource to be created.

Type: `string`

### resource\_group\_name

Description: (Required) Specifies the Resource Group where the Managed Kubernetes Cluster should exist. Changing this forces a new resource to be created.

Type: `string`

### vm\_size

Description: (Required) The size of the Virtual Machine, such as Standard\_DS2\_v2.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### agent\_pool\_name

Description: (Required) The name which should be used for the default Kubernetes Node Pool. Changing this forces a new resource to be created.

Type: `string`

Default: `"default"`

### availability\_zones

Description: (Optional) A list of Availability Zones across which the Node Pool should be spread. Changing this forces a new resource to be created.

Type: `list(string)`

Default: `null`

### diagnostics\_map

Description: (Required) contains the SA and EH details for operations diagnostics

Type: `map`

Default: `null`

### diagnostics\_settings

Description: (Required) configuration object describing the diagnostics

Type: `any`

Default: `null`

### dns\_service\_ip

Description: (Optional) IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns). Changing this forces a new resource to be created.

Type: `string`

Default: `"10.2.0.10"`

### docker\_bridge\_cidr

Description: (Optional) IP address (in CIDR notation) used as the Docker bridge IP address on nodes. Changing this forces a new resource to be created.

Type: `string`

Default: `"172.17.0.1/16"`

### kubernetes\_version

Description: (Optional) Version of Kubernetes specified when creating the AKS managed cluster. If not specified, the latest recommended version will be used at provisioning time (but won't auto-upgrade)

Type: `string`

Default: `null`

### load\_balancer\_type

Description: (Optional) Specifies the SKU of the Load Balancer used for this Kubernetes Cluster. Possible values are Basic and Standard. Defaults to Standard.

Type: `string`

Default: `"standard"`

### log\_analytics\_workspace

Description: (Required) contains the log analytics workspace details for operations diagnostics

Type: `any`

Default: `null`

### log\_analytics\_workspace\_id

Description: (Required) contains the log analytics workspace details for operations diagnostics

Type: `any`

Default: `null`

### max\_pods

Description: (Optional) The maximum number of pods that can run on each agent. Changing this forces a new resource to be created.

Type: `number`

Default: `30`

### name

Description:  (Required) The name of the Managed Kubernetes Cluster to create. Changing this forces a new resource to be created.

Type: `list(string)`

Default: `[]`

### network\_plugin

Description: (Required) Network plugin to use for networking. Currently supported values are azure and kubenet. Changing this forces a new resource to be created.

Type: `string`

Default: `"azure"`

### network\_policy

Description: (Optional) Sets up network policy to be used with Azure CNI. Network policy allows us to control the traffic flow between pods. Currently supported values are calico and azure. Changing this forces a new resource to be created.

Type: `string`

Default: `"azure"`

### node\_count

Description: (Optional) The initial number of nodes which should exist in this Node Pool. If specified this must be between 1 and 100 and between min\_count and max\_count.

Type: `string`

Default: `null`

### private\_cluster\_enabled

Description: Should this Kubernetes Cluster have its API server only exposed on internal IP addresses? This provides a Private IP Address for the Kubernetes API on the Virtual Network where the Kubernetes Cluster is located. Defaults to false. Changing this forces a new resource to be created

Type: `bool`

Default: `true`

### service\_cidr

Description:  (Optional) The Network Range used by the Kubernetes service. Changing this forces a new resource to be created.

Type: `string`

Default: `"10.2.0.0/16"`

### tags

Description: standard tags

Type: `map(string)`

Default: `{}`

### vnet\_subnet\_id

Description: (Optional) The ID of a Subnet where the Kubernetes Node Pool should exist. Changing this forces a new resource to be created.

Type: `string`

Default: `null`

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

