module "vm1" {
  source                    = "./modules/vm-linux"
  instance_name             = "vm1"
  labels                    = { env = "prod", service = "vm1" }
  allow_stopping_for_update = true
  preemptible = true
  network_interfaces = [
    { subnet_id = yandex_vpc_subnet.vpc-subnet-0.id, ip_address = "192.168.99.10", nat = true }
  ]
  cloudconfig = "bootstrap/metadata.yml"
  secondary_disks = [
    { disk_name = "vm1-persistent-disk" }
  ]
}

module "vm2" {
  source                    = "./modules/vm-linux"
  instance_name             = "vm2"
  allow_stopping_for_update = true
  preemptible = true
  network_interfaces = [
    { subnet_id = yandex_vpc_subnet.vpc-subnet-0.id, ip_address = "192.168.99.20", nat = true }
  ]
  cloudconfig = "bootstrap/metadata.yml"
  secondary_disks = [
    { disk_name = "vm2-persistent-disk" }
  ]
}

resource "yandex_vpc_network" "vpc-network" {
  name = "vpc-network"
}

resource "yandex_vpc_subnet" "vpc-subnet-0" {
  name = "vpc-subnet-0"
  //zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.vpc-network.id
  v4_cidr_blocks = ["192.168.99.0/24"]
}

output "vm2-vm-info" {
  value = module.vm2.vm-info
}

output "vm1-vm-info" {
  value = module.vm1.vm-info
}
