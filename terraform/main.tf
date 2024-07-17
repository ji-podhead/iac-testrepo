
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
 

