resource "dns_a_record_set" "set-dns-vms" {

  for_each = var.vms

  zone = "lan.aaroncody.com."
  name = each.key
  addresses = [each.value.ip4Address]
  ttl = 604800
}

resource "dns_a_record_set" "set-dns-vips" {

  for_each = var.vips

  zone = "lan.aaroncody.com."
  name = each.key
  addresses = [each.value.ip4Address]
  ttl = 604800
}