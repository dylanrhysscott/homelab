data "cloudflare_zero_trust_tunnel_cloudflared_virtual_network" "default_network" {
  account_id = var.account_id
  filter = {
    is_default = true
  }
}