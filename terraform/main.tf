terraform {

  required_providers {
      proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.1-rc3"
    }
     github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }

}
provider "github" {
  token = var.github_token
}
variable "github_token" {
  description = "GitHub API Token"
  type        = string
  sensitive = true
}
data "github_codespaces_secrets" "example_secret" {
  name = "PROXMOX_API_TOKEN_SECRET"
}



locals {
 // conf = data.external.config.result.login
  dir = "${path.module}"
  conf = jsondecode(file("${path.module}/proxmox/vm_config_1.json"))
}
# our external credentials file that thas  an secrets object that holds sensitive data 
variable "sec" {
  type = object({
    proxmox_api_token_secret = string
    proxmox_password = string
  })
  description = "An example object variable"
  sensitive   = true
}
provider "proxmox" {
  pm_api_url    = local.conf.proxmox_api_url
  pm_api_token_id = local.conf.proxmox_api_token_id
  pm_api_token_secret = data.github_codespaces_secrets.example_secret
   #var.sec.proxmox_api_token_secret
  pm_tls_insecure = true
}
resource "proxmox_vm_qemu" "wef" {
  name        = "wef2"
  target_node = "my-proxmox"
  tags        = "test"
  vmid        = "502"
  # Clone from windows 2k19-cloudinit template
  clone = "rockyBlank"
  os_type = "cloud-init"
# Cloud init options
  ipconfig0 = "ip=dhcp"
  memory       = 8192
  agent        = 1
  sockets      = 1
  cores        = 7
  # Set the boot disk paramters
  bootdisk     = "virtio"
  scsihw       = "virtio-scsi-pci"
    disks {
        scsi {
            scsi0 {
                disk {
                    backup             = true
                    cache              = "none"
                    discard            = true
                    emulatessd         = true
                    iothread           = true
                    mbps_r_burst       = 0.0
                    mbps_r_concurrent  = 0.0
                    mbps_wr_burst      = 0.0
                    mbps_wr_concurrent = 0.0
                    replicate          = true
                    size               = 8
                    storage            = "local-lvm"
                }
            }
        }
    }
   # Set the network
  network {
    model = "virtio"
    bridge = "vmbr0"
  } # end first network block
   lifecycle {
     ignore_changes = [
       network
     ]
  } # end lifecycle

}

#locals {
#  base_config = jsondecode(file("${path.module}/path_to_your_external_source.json"))
#  overrides = [
#    { name = "vm1", memory = 10240, agent = 2 },
#    { name = "vm2", memory = 20480, agent = 3 },
#    # Fügen Sie weitere Überschreibungen hinzu, wie benötigt
#  ]
#}