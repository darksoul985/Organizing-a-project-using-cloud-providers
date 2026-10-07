resource "yandex_iam_service_account" "s3-sa" {
  name        = var.service-account-s3
  description = "сервисный аккаунт для объектного хранилища"

  depends_on = [
    yandex_vpc_network.this,
    yandex_vpc_subnet.public
  ]
}

resource "yandex_resourcemanager_folder_iam_member" "s3-editor" {
  folder_id = var.folder_id
  role      = var.s3-editor
  member    = "serviceAccount:${yandex_iam_service_account.s3-sa.id}"

  depends_on = [
    yandex_iam_service_account.s3-sa
  ]
}

resource "yandex_iam_service_account_static_access_key" "s3-static-key" {
  service_account_id = yandex_iam_service_account.s3-sa.id
}

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
  role      = "compute.admin"
  member    = "serviceAccount:${yandex_iam_service_account.iam-sa.id}"

  depends_on = [
    yandex_iam_service_account.iam-sa
  ]
}

resource "yandex_resourcemanager_folder_iam_member" "load-balancer-editor" {
  folder_id = var.folder_id
  role      = "load-balancer.admin"
  member    = "serviceAccount:${yandex_iam_service_account.iam-sa.id}"

  depends_on = [
    yandex_iam_service_account.iam-sa
  ]
}
