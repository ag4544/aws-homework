  
terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.46.0"
    }
  }
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}

resource "yandex_compute_instance" "builder" {
  name        = "builder"
  platform_id = "standard-v2"
  service_account_id = "aje2nj0bqd1hk5i154ui"

  resources {
    cores  = 4
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd80iibe8asp4inkhuhr"
      type = "network-ssd"
      size = 15
    }
  }

  network_interface {
    subnet_id = "b0cmm0atdnj2r0bi73rp"
    nat = true
  }

  metadata = {
    ssh-keys = "debian:${var.ssh_public_key}"
  }
}

resource "yandex_compute_instance" "webserver" {
  name        = "webserver"
  platform_id = "standard-v2"
  service_account_id = "aje2nj0bqd1hk5i154ui"

  resources {
    cores  = 4
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd80iibe8asp4inkhuhr"
      type = "network-ssd"
      size = 15
    }
  }

  network_interface {
    subnet_id = "b0cmm0atdnj2r0bi73rp"
    nat = true
  }

  metadata = {
    ssh-keys = "debian:${var.ssh_public_key}"
  }
}

resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/hostinventory.tpl", {
    server_public_ip_builder = yandex_compute_instance.builder.network_interface.0.nat_ip_address,
  server_public_ip_webserver = yandex_compute_instance.webserver.network_interface.0.nat_ip_address })
  filename = "${path.module}/ansible/hosts.yml"
}

output "summary" {
  value = [yandex_compute_instance.builder.network_interface.0.nat_ip_address, yandex_compute_instance.webserver.network_interface.0.nat_ip_address]
}

resource "null_resource" "ansible_playbook" {
  provisioner "local-exec" {
    command = "sleep 30 && ansible-playbook -i ./ansible/hosts.yml ./ansible/main.yml"
  }
  depends_on = [local_file.ansible_inventory]
}