terraform {
  required_version = ">= 1.0"
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 6"
    }
  }
}

resource "cloudflare_zero_trust_access_identity_provider" "identity_provider" {
  config = {
    client_id     = var.identity_provider_client_id
    client_secret = var.identity_provider_client_secret
  }
  name       = var.identity_provider_name
  type       = var.identity_provider_type
  account_id = var.account_id
}

resource "cloudflare_zero_trust_tunnel_cloudflared" "tunnel" {
  account_id = var.account_id
  name       = var.name
  config_src = "cloudflare"
}

resource "cloudflare_zero_trust_access_policy" "access_policy" {
  account_id = var.account_id
  decision   = "allow"
  name       = "Zero Trust Access Policy"
  include = [
    {
      email = {
        email = var.email
      }
    }
  ]
}

resource "cloudflare_zero_trust_tunnel_cloudflared_route" "homelab_tunnel_routes" {
  for_each           = var.warp_routes
  account_id         = var.account_id
  network            = each.value
  comment            = each.key
  tunnel_id          = cloudflare_zero_trust_tunnel_cloudflared.tunnel.id
  virtual_network_id = data.cloudflare_zero_trust_tunnel_cloudflared_virtual_network.default_network.id
}

resource "cloudflare_zero_trust_device_custom_profile" "custom_device_profile" {
  count = var.device_profile != null ? 1 : 0
  account_id = var.account_id
  name       = var.device_profile.name
  precedence = var.device_profile.precedence
  match      = var.device_profile.match
  include    = var.device_profile.include
}