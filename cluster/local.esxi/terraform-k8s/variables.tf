variable "vms" {
  default = {
    master-1 = {
      tpIndex    = 0,
      ip4Address = "192.168.0.51",
      rpIndex    = 0,
      dsIndex0   = 1,
      dsIndex1   = 1,
      disk1size  = 24,
      cpus       = 2,
      mem        = 3072
    },
    master-2 = {
      tpIndex    = 0,
      ip4Address = "192.168.0.52",
      rpIndex    = 1,
      dsIndex0   = 2,
      dsIndex1   = 2,
      disk1size  = 24,
      cpus       = 2,
      mem        = 3072
    },
    master-3 = {
      tpIndex    = 0,
      ip4Address = "192.168.0.53",
      rpIndex    = 2,
      dsIndex0   = 3,
      dsIndex1   = 3,
      disk1size  = 24,
      cpus       = 2,
      mem        = 3072
    },
    worker-1 = {
      tpIndex    = 0,
      ip4Address = "192.168.0.56",
      rpIndex    = 0,
      dsIndex0   = 1,
      dsIndex1   = 1,
      disk1size  = 24,
      cpus       = 4,
      mem        = 16000
    },
    worker-2 = {
      tpIndex    = 0,
      ip4Address = "192.168.0.57",
      rpIndex    = 0,
      dsIndex0   = 1,
      dsIndex1   = 1,
      disk1size  = 24,
      cpus       = 4,
      mem        = 16000
    },
    worker-3 = {
      tpIndex    = 0,
      ip4Address = "192.168.0.58",
      rpIndex    = 1,
      dsIndex0   = 2,
      dsIndex1   = 2,
      disk1size  = 24,
      cpus       = 4,
      mem        = 16000
    },
    worker-4 = {
      tpIndex    = 0,
      ip4Address = "192.168.0.59",
      rpIndex    = 1,
      dsIndex0   = 2,
      dsIndex1   = 2,
      disk1size  = 24,
      cpus       = 4,
      mem        = 16000
    },
    worker-5 = {
      tpIndex    = 0,
      ip4Address = "192.168.0.60",
      rpIndex    = 2,
      dsIndex0   = 3,
      dsIndex1   = 3,
      disk1size  = 24,
      cpus       = 4,
      mem        = 16000
    },
    worker-6 = {
      tpIndex    = 0,
      ip4Address = "192.168.0.61",
      rpIndex    = 2,
      dsIndex0   = 3,
      dsIndex1   = 3,
      disk1size  = 24,
      cpus       = 4,
      mem        = 16000
    },
    worker-7 = {
      tpIndex    = 0,
      ip4Address = "192.168.0.62",
      rpIndex    = 2,
      dsIndex0   = 3,
      dsIndex1   = 3,
      disk1size  = 24,
      cpus       = 4,
      mem        = 16000
    },
    worker-8 = {
      tpIndex    = 0,
      ip4Address = "192.168.0.63",
      rpIndex    = 2,
      dsIndex0   = 3,
      dsIndex1   = 3,
      disk1size  = 24,
      cpus       = 4,
      mem        = 16000
    },
    worker-gpu1 = {
      tpIndex    = 1,
      ip4Address = "192.168.0.178",
      rpIndex    = 3,
      dsIndex0   = 2,
      dsIndex1   = 2,
      disk1size  = 24,
      cpus       = 4,
      mem        = 16000
    },
    worker-gpu2 = {
      tpIndex    = 2,
      ip4Address = "192.168.0.179",
      rpIndex    = 4,
      dsIndex0   = 3,
      dsIndex1   = 3,
      disk1size  = 24,
      cpus       = 4,
      mem        = 16000
    }
  }
}

variable "vips" {
  default = {
    k8s = {
      ip4Address = "192.168.0.233",
    },
    nfs= {
      ip4Address = "192.168.0.231",
    }
  }
}