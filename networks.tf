resource "yandex_vpc_network" "this" {
  name = var.vpc_network
}

resource "yandex_vpc_subnet" "public" {
  name           = var.vpc_subnet_public
  network_id     = yandex_vpc_network.this.id
  zone           = var.default_zone
  v4_cidr_blocks = var.default_cidr_public

  depends_on = [
    yandex_vpc_network.this
  ]
}

