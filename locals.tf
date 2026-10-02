locals {
  ssh_public_key = file("~/.ssh/ycloud.pub")
  vm_metadata = {
    user-data = templatefile("${path.module}/cloud-init.yaml.tpl", {
      ssh_user       = var.ssh_user
      ssh_public_key = local.ssh_public_key
    })
  }
}
