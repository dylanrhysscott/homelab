terraform {
  backend "s3" {}
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

module "zero_trust" {
  source                          = "./modules/zero-trust"
  account_id                      = var.cloudflare_account_id
  email                           = var.email
  identity_provider_client_id     = var.identity_provider_client_id
  identity_provider_client_secret = var.identity_provider_client_secret
  warp_routes                     = var.private_network_routes
}