variable ipaddy {
  type      = string
  default   = ""
}

variable inter {
  type      = string 
  default   = ""
}

variable hostname {
  type      = string
  default   = ""
}

variable tshirt_mapping {
  description = "mapping tshirt to image"
  default = {
    "Small" = "CentOS-7-x86_64-GenericCloud.qcow2",
    "Medium" = "CentOS-7-20GB.qcow2",
    "Large" = "CentOS-7-50GB.qcow2"
    "Rhel8" = "CentOS-8-GenericCloud-8.3.2011-20201204.2.x86_64.qcow2"
    "Centos9" = "CentoOS-9-30GB.qcow2"
  }
}


variable tshirt {
  type      = string
  default   = "CentOS-7-x86_64-GenericCloud.qcow2"
}


variable size {
  type      = string
  default   = "Small"
}

variable vmpool {
  type      = string
  default   = ""
}

variable cpu_num {
  type      = string
  default   = 1
}
