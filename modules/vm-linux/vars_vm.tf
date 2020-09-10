variable instance_name {
  description = "Instance name"
}

variable "zone" {
  description = "The availability zone where the virtual machine will be created"
  default     = null
}

variable "platform_id" {
  description = "The type of virtual machine to create"
  default     = "standard-v1"
}

variable "description" {
  description = "VM description"
  default     = ""
}

variable "hostname" {
  description = "Host name for the instance"
  default     = ""
}

variable "cpu_count" {
  description = "CPU count"
  default     = 2
}

variable "cpu_usage" {
  description = "CPU % usage"
  default     = 5
}

variable "ram" {
  description = "Amount of RAM"
  default     = 2
}

#ubuntu 20.04 lts >> yc compute image list --folder-id
variable "image" {
  description = "Image name"
  default     = "ubuntu-2004-lts"
}

variable "disk_size" {
  description = "Boot disk size"
  default     = 10
}

variable "network_interfaces" {
  description = "List of network interfaces"
}

variable "secondary_disks" {
  description = "List of secondary attaced disks"
  default     = []
}

variable "preemptible" {
  description = "scheduling_policy preemptible"
  default     = false
}

variable "pub_key_path" {
  description = "ssh public key path"
  default     = "~/.ssh/id_rsa.pub"
}

variable "priv_key_path" {
  description = "ssh private key path"
  default     = "~/.ssh/id_rsa"
}

variable "allow_stopping_for_update" {
  description = "If true, allows Terraform to stop the instance in order to update its properties."
  default     = false
}

variable "cloudconfig" {
  description = "Path to file with cloudconfig"
  default = ""
}

variable "labels" {
  description = "Labaels for VM instance"
  type = map
  default = null
}
