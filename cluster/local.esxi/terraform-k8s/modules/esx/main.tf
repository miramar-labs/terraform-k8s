# DC
data "vsphere_datacenter" "dc" {
  name = "Miramar Labs DC"
}

# Resource Pools
data "vsphere_resource_pool" "pool" {
  count         = 8
  name          = var.rpools[count.index]
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "compute-1" {
  name          = "compute-1"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "compute-2" {
  name          = "compute-2"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "compute-3" {
  name          = "compute-3"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "storage-1" {
  name          = "storage-1"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "storage-2" {
  name          = "storage-2"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "storage-3" {
  name          = "storage-3"
  datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_resource_pool" "gpu-compute-1" {
  name          = "gpu-compute-1"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "gpu-compute-2" {
  name          = "gpu-compute-2"
  datacenter_id = data.vsphere_datacenter.dc.id
}

# Datastores
data "vsphere_datastore" "ds" {
  count         = 5
  name          = var.datastores[count.index]
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "datastore-nas" {
  name          = "datastore-nas"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "datastore-ssd" {
  name          = "datastore-ssd"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "datastore-ssd2" {
  name          = "datastore-ssd2"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "datastore-ssd3" {
  name          = "datastore-ssd3"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "datastore-ssd4" {
  name          = "datastore-ssd4"
  datacenter_id = data.vsphere_datacenter.dc.id
}

# Networks
data "vsphere_network" "network" {
  name          = "VM Network"
  datacenter_id = data.vsphere_datacenter.dc.id
}

## Templates
data "vsphere_virtual_machine" "templates" {
  count         = 3
  name          = var.templates[count.index]
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template-ubu1804" {
  name          = "ubu18.04-tmpl"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template-ubu1804-titanX" {
  name          = "ubu18.04-titanx-tmpl"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template-ubu1804-1050Ti" {
  name          = "ubu18.04-1050Ti-tmpl"
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "vm" {

  for_each = var.vms

  name             = each.key
  resource_pool_id = data.vsphere_resource_pool.pool[each.value.rpIndex].id
  num_cpus         = each.value.cpus
  memory           = each.value.mem
  memory_reservation = each.value.mem 
  guest_id         = data.vsphere_virtual_machine.templates[each.value.tpIndex].guest_id
  scsi_type        = data.vsphere_virtual_machine.templates[each.value.tpIndex].scsi_type

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.templates[each.value.tpIndex].network_interface_types[0]
  }

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.templates[each.value.tpIndex].disks.0.size
    eagerly_scrub    = false
    thin_provisioned = false
    datastore_id     = data.vsphere_datastore.ds[each.value.dsIndex0].id
  }

  disk {
    label            = "disk1"
    size             = each.value.disk1size
    eagerly_scrub    = false
    thin_provisioned = false
    datastore_id     = data.vsphere_datastore.ds[each.value.dsIndex1].id
    unit_number      = 1
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.templates[each.value.tpIndex].id

    customize {
      linux_options {
        host_name = each.key
        domain    = "lan.aaroncody.com"
      }

      network_interface {
        ipv4_address = each.value.ip4Address
        ipv4_netmask = 24
      }

      ipv4_gateway = "192.168.0.1"

      dns_server_list = ["192.168.0.254", "8.8.8.8", "4.4.4.4"]
      dns_suffix_list = ["lan.aaroncody.com"]
    }
  }
}