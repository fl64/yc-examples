// Disks can be created in a separate tf-manifest

resource "yandex_compute_disk" "vm1-persistent-disk" {
  name = "vm1-persistent-disk"
  type = "network-hdd"
  size = 20
  //zone = "ru-central1-a"
  labels = {
    environment = "prod"
  }
}

resource "yandex_compute_disk" "vm2-persistent-disk" {
  name = "vm2-persistent-disk"
  type = "network-hdd"
  size = 20
  //zone = "ru-central1-a"
  labels = {
    environment = "prod"
  }
}
