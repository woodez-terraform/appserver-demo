terraform {
  backend "pg" {}
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
      version = "0.6.3"
    }
  }
}


# add the provider
provider "libvirt" {
 uri = "qemu:///system"
}


module "rhel_server_libvirtd" {
  source = "github.com/woodez-terraform/rhel-server-libvirtd//modules/services/rhel7-server?ref=v1.3"
  ipaddy = var.ipaddy
  hostname = var.hostname
  vmpool = var.vmpool
}
