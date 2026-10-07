resource "yandex_storage_bucket" "s3-storage" {
  access_key = yandex_iam_service_account_static_access_key.s3-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.s3-static-key.secret_key
  bucket    = var.bucket-name
  max_size = 1073741824

  anonymous_access_flags {
    read = true
    list = false
  }

  depends_on = [
    yandex_iam_service_account_static_access_key.s3-static-key,
    yandex_resourcemanager_folder_iam_member.s3-editor
  ]
}

resource "yandex_storage_object" "kitten" {
  access_key = yandex_iam_service_account_static_access_key.s3-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.s3-static-key.secret_key
  bucket = yandex_storage_bucket.s3-storage.id
  key = "${var.s3-object-key}.jpg"
  source = "./${var.s3-object-key}.jpg"
  content_type = "image/jpg"
  depends_on = [
    yandex_storage_bucket.s3-storage
  ]
}
