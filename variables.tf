# cloud
variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-d"
  description = "Объявляем дефолтную зону сети"
}

variable "service-account-s3" {
  type        = string
  default     = "sa-encripted"
  description = "название сервисного аккаунта для управления s3"
}

variable "bucket-name" {
  type        = string
  default     = "shirobokov-s3-bucket"
  description = "название объектного хранилища"
}

variable "bucket-name-site" {
  type        = string
  default     = "shirobokov-s3-bucket-site"
  description = "название объектного хранилища"
}

# Site
variable "domain_name" {
  default = "my-static-site-bucket.website.yandexcloud.net"
}

variable "site_index" {
  default = "index.html"
}

variable "site_content_type" {
  default = "text/html"
}

variable "site_error" {
  default = "error.html"
}

# Image
variable "image_file" {
  default = "kitten.jpg"
}

variable "image_key" {
  default = "kitten.jpg"
}

variable "image_content_type" {
  default = "image/jpg"
}

variable "public_read_acl" {
  default = "public-read"
}

variable "s3-admin" {
  type        = string
  default     = "storage.admin"
  description = "роль СА s3"
}

variable "s3-object-key" {
  type    = string
  default = "kitten"
}

variable "kms" {
  type = map(string)
  default = {
    name            = "same_kms"
    description     = "default kms key"
    algorithm       = "AES_128"
    rotation_period = "8760h"
  }
}
