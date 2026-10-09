terraform {
  required_version = "~>1.15.2"

  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  # service_account_key_file = file("key.json")
  zone      = var.default_zone
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
}
