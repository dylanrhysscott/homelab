terraform {
  required_version = ">= 1.0"
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5"
    }
  }
}

resource "cloudflare_dns_record" "cluster_record" {
  for_each = var.cluster_map
  zone_id  = var.cloudflare_zone_id
  content  = each.value
  name     = "cluster.${data.cloudflare_zone.zone.name}"
  proxied  = false
  type     = "A"
  ttl      = "1"
}

resource "cloudflare_dns_record" "node_record" {
  for_each = var.cluster_map
  zone_id  = var.cloudflare_zone_id
  content  = each.value
  name     = "${each.key}.${data.cloudflare_zone.zone.name}"
  proxied  = false
  type     = "A"
  ttl      = "1"
}