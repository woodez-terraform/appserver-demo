terraform {
  backend "pg" {
    conn_str="postgres://tf_user:jandrew28@192.168.2.213/terraform_backend?sslmode=disable"
  }
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
  source = "github.com/woodez-terraform/rhel-server-libvirtd//modules/services/rhel7-server"
  ipaddy = var.ipaddy
  interface = var.inter
  hostname = var.hostname
  tshirt = "${lookup(var.tshirt_mapping, var.size)}"
  vmpool = var.vmpool
}
