output "image_url" {
  description = "Direct URL to the image in S3 bucket"
  value       = "https://${yandex_storage_bucket.s3-storage.bucket_domain_name}/${yandex_storage_object.kitten.key}"
}

output "website_url" {
  description = "URL to access the website via load balancer"
  value = "http://${[
    for listener in yandex_lb_network_load_balancer.lb-1.listener :
    [
      for spec in listener.external_address_spec :
      spec.address
    ][0]
    if listener.name == "network-load-balancer-same-listener"
  ][0]}"
}

# output "public-vm-internal-ip" {
#   value = yandex_compute_instance.public-vm.network_interface[0].ip_address
# }
output "lb_ip" {
  description = "Load balancer IP address"
  value = [
    for listener in yandex_lb_network_load_balancer.lb-1.listener :
    [
      for spec in listener.external_address_spec :
      spec.address
    ][0]
    if listener.name == "network-load-balancer-same-listener"
  ][0]
}
