resource "yandex_storage_bucket" "s3-storage-encripted" {
  bucket     = var.bucket-name
  access_key = yandex_iam_service_account_static_access_key.s3-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.s3-static-key.secret_key

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.main.id
        sse_algorithm     = "aws:kms"
      }
    }
  }
  depends_on = [
    yandex_iam_service_account.sa
  ]
}

resource "yandex_storage_bucket_grant" "bucket_grant" {
  bucket     = yandex_storage_bucket.s3-storage-encripted.bucket
  access_key = yandex_iam_service_account_static_access_key.s3-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.s3-static-key.secret_key

  grant {
    id          = yandex_iam_service_account.sa.id
    permissions = ["FULL_CONTROL"]
    type        = "CanonicalUser"
  }

  depends_on = [
    yandex_storage_bucket.s3-storage-encripted
  ]
}

resource "yandex_storage_object" "kitten-kms" {
  bucket       = yandex_storage_bucket.s3-storage-encripted.id
  access_key   = yandex_iam_service_account_static_access_key.s3-static-key.access_key
  secret_key   = yandex_iam_service_account_static_access_key.s3-static-key.secret_key
  key          = "${var.s3-object-key}-encripted.jpg"
  source       = "./${var.s3-object-key}.jpg"
  content_type = "image/jpg"
  acl          = "public-read"

  depends_on = [
    yandex_storage_bucket.s3-storage-encripted
  ]
}


resource "yandex_storage_bucket" "static_site" {
  bucket     = var.bucket-name-site
  acl        = var.public_read_acl
  access_key = yandex_iam_service_account_static_access_key.s3-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.s3-static-key.secret_key

  website {
    index_document = var.site_index
    error_document = var.site_error
  }

  cors_rule {
    allowed_methods = ["GET", "HEAD"]
    allowed_origins = ["*"]
    allowed_headers = ["*"]
    max_age_seconds = 3600
  }
}

resource "yandex_storage_object" "index" {
  bucket       = yandex_storage_bucket.static_site.bucket
  access_key   = yandex_iam_service_account_static_access_key.s3-static-key.access_key
  secret_key   = yandex_iam_service_account_static_access_key.s3-static-key.secret_key
  key          = var.site_index
  source       = var.site_index
  content_type = var.site_content_type
  acl          = var.public_read_acl
}

resource "yandex_storage_object" "error" {
  bucket       = yandex_storage_bucket.static_site.bucket
  access_key   = yandex_iam_service_account_static_access_key.s3-static-key.access_key
  secret_key   = yandex_iam_service_account_static_access_key.s3-static-key.secret_key
  key          = var.site_error
  source       = var.site_error
  content_type = var.site_content_type
  acl          = var.public_read_acl
}

resource "yandex_storage_object" "site_image" {
  bucket       = yandex_storage_bucket.static_site.bucket
  access_key   = yandex_iam_service_account_static_access_key.s3-static-key.access_key
  secret_key   = yandex_iam_service_account_static_access_key.s3-static-key.secret_key
  key          = var.image_key
  source       = var.image_file
  content_type = var.image_content_type
  acl          = var.public_read_acl
}
