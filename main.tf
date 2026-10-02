data "yandex_compute_image" "ubuntu" {
  family = var.default_image
}

data "yandex_iam_service_account" "app_sa" {
  name = "service-one"
}


resource "yandex_compute_instance" "public-vm" {
  name = var.vm.default.name
  service_account_id = data.yandex_iam_service_account.app_sa.id
  platform_id = "standard-v3"

  resources {
    core_fraction = var.vm.default.core_fraction
    cores = var.vm.default.cores
    memory = var.vm.default.memory
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size = var.vm.default.hdd_size
      type = var.vm.default.hdd_type
      }
  }

  # Включаем прерываемость
  scheduling_policy {
    preemptible = var.vm.default.preemptible
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.public.id
    nat=true
  }

  metadata = local.vm_metadata
}


resource "yandex_compute_instance" "private-vm" {
  name = "privat-vm"
  service_account_id = data.yandex_iam_service_account.app_sa.id
  platform_id = "standard-v3"

  resources {
    core_fraction = var.vm.default.core_fraction
    cores = var.vm.default.cores
    memory = var.vm.default.memory
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size = var.vm.default.hdd_size
      type = var.vm.default.hdd_type
      }
  }

  # Включаем прерываемость
  scheduling_policy {
    preemptible = var.vm.default.preemptible
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.privat.id
  }

  metadata = local.vm_metadata
}
