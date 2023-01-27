module "yandex_instance_1" {
  source                = "./modules/create_vm"
  disk_name             = "sys-fluentsrv"
  disk_size             = "25"
  disk_type             = "network-hdd"
  cores                 = "2"
  memory                = "2"
  instance_family_image = "ubuntu-2204-lts"
  instance_subnet_name  = "a-ru-central1-a"
  instance_name         = "fluentsrv"
  instance_desc         = "fluentd server"
  zone_name             = "ru-central1-a"
}


