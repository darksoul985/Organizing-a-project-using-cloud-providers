resource "yandex_iam_service_account" "sa" {
  name        = var.service-account-s3
  description = "сервисный аккаунт для объектного хранилища"
}

# Назначение роли сервисному аккаунту
resource "yandex_resourcemanager_folder_iam_member" "s3-admin" {
  folder_id = var.folder_id
  role      = var.s3-admin
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"

  depends_on = [
    yandex_iam_service_account.sa
  ]
}

# Назначение роли KMS сервисному аккаунту
resource "yandex_resourcemanager_folder_iam_member" "kms-admin" {
  folder_id = var.folder_id
  role      = "kms.admin"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"

  depends_on = [
    yandex_iam_service_account.sa
  ]
}

// Создание статического ключа доступа
resource "yandex_iam_service_account_static_access_key" "s3-static-key" {
  service_account_id = yandex_iam_service_account.sa.id

  depends_on = [
    yandex_iam_service_account.sa
  ]
}

