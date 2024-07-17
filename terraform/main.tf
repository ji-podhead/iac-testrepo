
  terraform {
    required_providers {
        proxmox = {
        source  = "telmate/proxmox"
        version = "3.0.1-rc3"
      }
}
}

 

  output "test" {
    value = "data.vault_kv_secret_v2.github.data["github_token"]"
      sensitive = true
  }
