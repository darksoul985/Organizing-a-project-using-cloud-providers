resource "yandex_iam_service_account" "iam-sa" {
  name        = var.vm-service-accaunt
  description = "Сервисный аккаунт для управления группой ВМ."
  depends_on = [
    yandex_vpc_network.this,
    yandex_vpc_subnet.public
  ]
}

resource "yandex_resourcemanager_folder_iam_member" "editor" {
  folder_id = var.folder_id
  role      = "compute.editor"
  member    = "serviceAccount:${yandex_iam_service_account.iam-sa.id}"

  depends_on = [
    yandex_iam_service_account.iam-sa
  ]
}

resource "yandex_compute_instance_group" "vm-public" {
  name                = var.vm.default.name
  service_account_id  = "${yandex_iam_service_account.iam-sa.id}"
  instance_template {
    platform_id = "standard-v3"
    resources {
      # core_fraction = var.vm.default.core_fraction
      memory = var.vm.default.memory
      cores  = var.vm.default.cores
    }

    boot_disk {
      initialize_params {
        image_id = var.default_image_id
        # size = var.vm.default.hdd_size
        # type = var.vm.default.hdd_type
      }
    }

    network_interface {
      network_id         = "${yandex_vpc_network.this.id}"
      subnet_ids         = ["${yandex_vpc_subnet.public.id}"]
    }

    # scheduling_policy {
    #   preemptible = true
    # }

    metadata = local.vm_metadata
  }


  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  allocation_policy {
    zones = [var.default_zone]
  }

  deploy_policy {
    max_unavailable = 2
    max_expansion   = 1
  }

  health_check {
    interval            = 2
    timeout             = 1
    healthy_threshold   = 5
    unhealthy_threshold = 2
    http_options {
      port = var.http_options.port
      path = var.http_options.path
    }
  }

  load_balancer {
    target_group_name        = var.target_group_name
    target_group_description = var.target_group_description
  }

  depends_on = [
    yandex_resourcemanager_folder_iam_member.editor,
    yandex_vpc_subnet.public,
    yandex_storage_bucket.s3-storage,
    yandex_storage_object.kitten
  ]
}

resource "yandex_lb_network_load_balancer" "lb-1" {
  name = "network-load-balancer-same"

  listener {
    name = "network-load-balancer-same-listener"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_compute_instance_group.vm-public.load_balancer.0.target_group_id

    healthcheck {
      name = "http"
      interval              = 2
      timeout               = 1
      unhealthy_threshold   = 2
      healthy_threshold     = 5

      http_options {
        port = 80
        path = "/"
      }
    }
  }
}
