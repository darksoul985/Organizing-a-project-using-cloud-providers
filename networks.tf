resource "yandex_vpc_network" "this" {
    name = var.vpc_network
  }

resource "yandex_vpc_subnet" "public" {
  name           = var.vpc_subnet_public
  network_id     = yandex_vpc_network.this.id
  zone = var.default_zone
  v4_cidr_blocks = var.default_cidr_public
}

resource "yandex_vpc_subnet" "privat" {
  name           = var.vpc_subnet_privat
  network_id     = yandex_vpc_network.this.id
  zone = var.default_zone
  v4_cidr_blocks = var.default_cidr_privat
  route_table_id = yandex_vpc_route_table.nat-route.id
}
