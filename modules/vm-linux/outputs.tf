output "vm-info" {
  value = {
    ip_addr     = yandex_compute_instance.vm-linux.network_interface[*].ip_address
    nat_ip_addr = yandex_compute_instance.vm-linux.network_interface[*].nat_ip_address
    labels      = yandex_compute_instance.vm-linux.labels
  }
}
