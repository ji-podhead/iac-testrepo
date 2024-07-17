
  locals {
  // conf = data.external.config.result.login
    dir = "${path.module}"
    conf = jsondecode(file("${path.module}/../proxmox/vm_config_1.json"))
    repo = "Pod-Shop-App-Configs"
    owner="ji-podhead"
  }


  skip_child_token = true
  
}
 

