variable "vms" {}

variable "templates" {
  type    = list(string)
  default = ["ubu18.04-tmpl", "ubu18.04-titanx-tmpl", "ubu18.04-1050Ti-tmpl"]
}
variable "datastores" {
  type    = list(string)
  default = ["datastore-nas", "datastore-ssd", "datastore-ssd2", "datastore-ssd3", "datastore-ssd4"]
}
variable "rpools" {
  type = list(string)
  default = [
    "compute-1",
    "compute-2",
    "compute-3",
    "gpu-compute-1",
    "gpu-compute-2",
    "storage-1",
    "storage-2",
    "storage-3"]
}