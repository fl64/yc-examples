
variable cloud_token {
}
variable cloud_id {
}
variable folder_id {
}
provider "yandex" {
  token     = var.cloud_token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = "ru-central1-a"
}
