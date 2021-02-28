module "esx" {
  source="./modules/esx"
  vms = var.vms
}

module "dns-vms" {
  source="./modules/dns"
  vms = var.vms
  vips = {}
}

module "dns-vips" {
  source="./modules/dns"
  vms = {}
  vips = var.vips
}