variable "cluster_map" {
  type = map(string)
}

variable "email" {
  type      = string
  sensitive = true
}

variable "cloudflare_zone_id" {
  type = string
}

variable "cloudflare_account_id" {
  type = string
}

variable "identity_provider_client_id" {
  type      = string
  sensitive = true
}

variable "identity_provider_client_secret" {
  type      = string
  sensitive = true
}