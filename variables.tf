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

variable "vpc_network" {
  type        = string
  default     = "main_network"
  description = "Объявляем дефолтную сеть"
}

# Объявляем дефолтную подсеть
variable "vpc_subnet_public" {
  type        = string
  default     = "public"
  description = "subnet name"
}

variable "vpc_subnet_privat" {
  type        = string
  default     = "privat"
  description = "subnet name"
}

# Объявляем дефолтный v4_cidr
variable "default_cidr_public" {
  type        = list(string)
  default     = ["192.168.10.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "default_cidr_privat" {
  type        = list(string)
  default     = ["192.168.20.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

# Дефолтный образ ОС
variable "default_image_id" {
  type    = string
  default = "fd827b91d99psvq5fjit"
}

# Дефолтный пользователь
variable "ssh_user" {
  type        = string
  default     = "solo"
  description = "пользователь на вм"
}

variable "vm-service-accaunt" {
  type = string
  default = "iam-sa"
}

variable "vm" {
  type = map(object({
    name          = string,
    cores         = number,
    memory        = number,
    core_fraction = number,
    hdd_size      = number,
    hdd_type      = string,
    preemptible   = bool,
  }))
  default = {
    default = {
      name          = "vm-public",
      cores         = 2,
      memory        = 4,
      core_fraction = 20,
      hdd_size      = 20,
      hdd_type      = "network-hdd",
      preemptible   = true,
    }
  }
}

variable "http_options" {
  default = {
    port = 80
    path = "/"
  }
}

variable "target_group_name" {
  default = "target-group"
}

variable "target_group_description" {
  default = "Целевая группа Network Load Balancer"
}

variable "service-account-s3" {
  type        = string
  default     = "s3-sa"
  description = "название сервисного аккаунта для управления s3"
}



variable "bucket-name" {
  type        = string
  default     = "shirobokov-s3-bucket"
  description = "название объектного хранилища"
}

variable "s3-editor" {
  type        = string
  default     = "storage.editor"
  description = "роль СА s3"
}

variable "s3-object-key" {
  type = string
  default = "kitten"
}
