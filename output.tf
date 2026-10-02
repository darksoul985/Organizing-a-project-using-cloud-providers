output "network_id" {
  value = yandex_vpc_network.this.id
}

output "public_subnet" {
  value = yandex_vpc_subnet.public.id
}

output "privat_subnet" {
  value = yandex_vpc_subnet.privat.id
}

output "nat" {
  value = yandex_compute_instance.nat.network_interface[0].nat_ip_address
}

output "privat-vm" {
  value = yandex_compute_instance.private-vm.network_interface[0].nat_ip_address
}

output "private_vm_internal_ip" {
  value = yandex_compute_instance.private-vm.network_interface.0.ip_address
}


output "public-vm-ip" {
  value = yandex_compute_instance.public-vm.network_interface[0].nat_ip_address
}

output "public-vm-internal-ip" {
  value = yandex_compute_instance.public-vm.network_interface[0].ip_address
}
