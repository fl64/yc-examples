data "yandex_compute_image" "image" {
  family = var.image
}

//find secondary compute disks by their name
data "yandex_compute_disk" "disks" {
  count = length(var.secondary_disks)
  name  = var.secondary_disks[count.index].disk_name
}

resource "yandex_compute_instance" "vm-linux" {
  name = var.instance_name
  // if hosntame empty, use instance_name https://www.terraform.io/docs/configuration/functions/coalesce.html
  hostname                  = coalesce(var.hostname, var.instance_name)
  description               = var.description
  allow_stopping_for_update = var.allow_stopping_for_update
  zone                      = var.zone
  labels                    = var.labels
  resources {
    cores         = var.cpu_count
    memory        = var.ram
    core_fraction = var.cpu_usage
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.image.id
      size     = var.disk_size
    }
  }

  dynamic secondary_disk {
    for_each = data.yandex_compute_disk.disks //var.disk
    content {
      disk_id = secondary_disk.value.id //secondary_disk.value["disk_id"]// //
      //auto_delete = lookup(secondary_disk.value, "auto_delete", false)
    }
  }

  dynamic network_interface {
    for_each = var.network_interfaces
    content {
      subnet_id      = network_interface.value["subnet_id"]
      nat            = lookup(network_interface.value, "nat", false)           // optional
      ip_address     = lookup(network_interface.value, "ip_address", null)           // optional
      nat_ip_address = lookup(network_interface.value, "nat_ip_address", null) // optional
    }
  }

  scheduling_policy {
    preemptible = var.preemptible
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.pub_key_path)}"
    user-data = "${var.cloudconfig != "" ? file(var.cloudconfig) : ""}"
  }
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      host        = yandex_compute_instance.vm-linux.network_interface.0.nat_ip_address
      user        = "ubuntu"
      private_key = file(var.priv_key_path)
    }
    inline = ["cat /etc/*release"]
  }
}
