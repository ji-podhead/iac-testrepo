
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
  locals {
  // conf = data.external.config.result.login
    dir = "${path.module}"
    conf = jsondecode(file("${path.module}/../proxmox/vm_config_1.json"))
    repo = "Pod-Shop-App-Configs"
    owner="ji-podhead"
  }
  variable "vault_token"{
    type        = string
    sensitive = true
  }
  variable "vault_role_id"{
    type        = string
    sensitive = true

  }
  variable "vault_role_secret_id"{
    type        = string
    sensitive = true
<<<<<<< Updated upstream

  }
provider "vault" {
  address = "http://127.0.0.1:8200"
token = var.vault_token
#  NOT WORKING!!!
#   auth_login {
#    method = "approle"
#    path = "auth/approle/login"
#    parameters = {
#      role_id   = var.vault_role_id
#      secret_id = var.vault_role_secret_id
#    }
#    
#  }
#
  skip_child_token = true
  
}
 

  data "vault_kv_secret_v2" "github" {
  mount = "keyvalue"
  name  = "terraform/github"
}
  data "vault_kv_secret_v2" "proxmox" {
  mount = "keyvalue"
  name  = "terraform/proxmox"
}
  output "test" {
    value = data.vault_kv_secret_v2.github.data["github_token"]
      sensitive = true
  }
  provider "github" {
    token = data.vault_kv_secret_v2.github.data["github_token"]
    
  }
     /*
  provider "proxmox" {
    pm_api_url    = local.conf.proxmox_api_url
    pm_api_token_id = local.conf.proxmox_api_token_id
    pm_api_token_secret = data.vault_kv_secret_v2.proxmox.data["proxmox_api_token_secret"]
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

  data "github_actions_public_key" "example_public_key" {
    repository = "Pod-Shop-App-Configs"
  }
  resource "github_actions_secret" "example_secret" {
    repository       = "Pod-Shop-App-Configs"
    secret_name      = "example_secret_name"
    plaintext_value  = "var.some_secr^et_string"
  }
  */



=======

  }
provider "vault" {
  address = "http://127.0.0.1:8200"
token = var.vault_token
#  NOT WORKING!!!
#   auth_login {
#    method = "approle"
#    path = "auth/approle/login"
#    parameters = {
#      role_id   = var.vault_role_id
#      secret_id = var.vault_role_secret_id
#    }
#    
#  }
#
  skip_child_token = true
  
}
 

  data "vault_kv_secret_v2" "github" {
  mount = "keyvalue"
  name  = "terraform/github"
}
  data "vault_kv_secret_v2" "proxmox" {
  mount = "keyvalue"
  name  = "terraform/proxmox"
}
  output "test" {
    value = data.vault_kv_secret_v2.github.data["github_token"]
      sensitive = true
  }
  provider "github" {
    token = data.vault_kv_secret_v2.github.data["github_token"]
    
  }
    
  provider "proxmox" {
    pm_api_url    = local.conf.proxmox_api_url
    pm_api_token_id = local.conf.proxmox_api_token_id
    pm_api_token_secret = data.vault_kv_secret_v2.proxmox.data["proxmox_api_token_secret"]
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
 /*
  data "github_actions_public_key" "example_public_key" {
    repository = "Pod-Shop-App-Configs"
  }
  resource "github_actions_secret" "example_secret" {
    repository       = "Pod-Shop-App-Configs"
    secret_name      = "example_secret_name"
    plaintext_value  = "var.some_secr^et_string"
  }
  */
  #locals {
  #  base_config = jsondecode(file("${path.module}/path_to_your_external_source.json"))
  #  overrides = [
  #    { name = "vm1", memory = 10240, agent = 2 },
  #    { name = "vm2", memory = 20480, agent = 3 },
  #    # Fügen Sie weitere Überschreibungen hinzu, wie benötigt
  #  ]
  #}
  # our external credentials file that thas  an secrets object that holds sensitive data 
>>>>>>> Stashed changes
