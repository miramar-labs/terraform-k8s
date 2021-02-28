terraform {
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "1.24.3"
    }
    dns = {
      source = "hashicorp/dns"
      version = "3.1.0"
    }
  }
}

provider "vsphere" {
  vsphere_server       = "vcsa.lan.aaroncody.com"
  user                 = "administrator@lan.aaroncody.com"
  password             = "VARS4ghet*skax"
  allow_unverified_ssl = true
}

provider "dns" {
  update {
    server        = "192.168.0.254"
    key_name      = "rndc-key."
    key_algorithm = "hmac-md5"
    key_secret    = "pVrhjAzTEODWFFXprT+01g=="
  }
}