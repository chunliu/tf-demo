variable "ak" {
  description = "BytePlus access key"
  type = string
}

variable "sk" {
  description = "BytePlus secret key"
  type = string
}

variable "cr_domains" {
  description = "CR domains"
  type = list(string)
}

variable "cr_instance" {
  description = "CR instance"
  type = string
}

variable "create_jumpbox" {
  description = "Create jumpbox"
  type = bool
  default = false
}

variable "create_nginx_ingress" {
  description = "Create nginx ingress"
  type = bool
  default = false
}