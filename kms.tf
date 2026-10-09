resource "yandex_kms_symmetric_key" "main" {
  name              = var.kms.name
  description       = var.kms.description
  default_algorithm = var.kms.algorithm
  rotation_period   = var.kms.rotation_period
}

