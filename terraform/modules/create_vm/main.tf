resource "yandex_compute_instance" "vm" {
  description        = var.instance_desc
  name               = var.instance_name
  platform_id        = var.platform
  service_account_id = data.yandex_iam_service_account.user_id.id
  zone               = var.zone_name

  resources {
    cores         = var.cores
    memory        = var.memory
    core_fraction = var.core_fract
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.img.id
      name     = var.disk_name
      size     = var.disk_size
      type     = var.disk_type
    }
  }

  network_interface {
    subnet_id = data.yandex_vpc_subnet.subnet.id
    nat       = var.nat
  }

  metadata = {
    user-data          = "${file("~/.metadata/yc_users.txt")}"
    serial-port-enable = 1
  }
}

# Получаем id требуемого образа

data "yandex_compute_image" "img" {
  family = var.instance_family_image
}

#Получаем id подсети для инстанса

data "yandex_vpc_subnet" "subnet" {
  name = var.instance_subnet_name
}

# Получаем id сервисного аккаунта

data "yandex_iam_service_account" "user_id" {
  name = "esm"
}

