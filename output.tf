output "static_image_url" {
  description = "Direct URL to the image in S3 bucket"
  value       = "https://${yandex_storage_bucket.s3-storage-encripted.bucket_domain_name}/${yandex_storage_object.kitten-kms.key}"
}

output "kms_key_id" {
  value = yandex_kms_symmetric_key.main.id
}

output "encripted_bucket_name" {
  value = yandex_storage_bucket.s3-storage-encripted.bucket
}

output "static_site_url" {
  description = "URL статического сайта"
  value       = "https://${yandex_storage_bucket.static_site.website_endpoint}"
}

output "static_site_domain" {
  description = "Домен статического сайта"
  value       = yandex_storage_bucket.static_site.website_endpoint
}
