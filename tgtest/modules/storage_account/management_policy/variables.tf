# VARIABLES

##########################
### REQUIRED VARIABLES ###
##########################

variable "storage_account_id" {
  description = "The storage account ID where the policy will be created"
  type        = string
}

##########################
### OPTIONAL VARIABLES ###
##########################

variable "rules" {
  description = "Rules definition for the management policy"
  type        = any
}