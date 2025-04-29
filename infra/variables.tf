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

variable "private_network_routes" {
  type    = map(string)
  default = {}
}

variable "device_profile" {
  type = object({
    name       = string
    precedence = string
    match      = string
    include = optional(list(object({
      address     = optional(string)
      host        = optional(string)
      description = optional(string)
    })))
  })
  default = null
}