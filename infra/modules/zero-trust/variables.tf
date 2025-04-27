variable "account_id" {
  type = string
}

variable "name" {
  type    = string
  default = "homelab"
}

variable "email" {
  type      = string
  sensitive = true
}

variable "identity_provider_name" {
  type    = string
  default = "Homelab"
}

variable "identity_provider_type" {
  type    = string
  default = "google"
}

variable "identity_provider_client_id" {
  type      = string
  sensitive = true
}

variable "identity_provider_client_secret" {
  type      = string
  sensitive = true
}

variable "warp_routes" {
  type    = map(string)
  default = {}
}