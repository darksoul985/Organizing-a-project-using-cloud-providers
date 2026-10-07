locals {
  ssh_public_key = file("~/.ssh/ycloud.pub")
  vm_metadata = {
    user-data = templatefile("${path.module}/cloud-init.yaml.tpl", {
      ssh_user       = var.ssh_user
      ssh_public_key = local.ssh_public_key
      image_url       = "https://${yandex_storage_bucket.s3-storage.bucket}.storage.yandexcloud.net/${yandex_storage_object.kitten.key}"
    })
  }
}
