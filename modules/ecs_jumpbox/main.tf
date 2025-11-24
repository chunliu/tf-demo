terraform {
  required_providers {
    byteplus = {
      source = "byteplus-sdk/byteplus"
      version = "0.0.22"
    }
  }
}

data "byteplus_images" "ecs_images" {
    os_type = "Linux"
    instance_type_id = "ecs.c3il.xlarge"
    name_regex = "Ubuntu 24.04"
}

resource "byteplus_security_group" "ecs_security_group" {
    security_group_name = "tf-ecs-sg"
    vpc_id      = var.vpc_id
}

resource "byteplus_ecs_instance" "ecs_jumpbox" {
    host_name            = "gh-runner1"
    image_id             = data.byteplus_images.ecs_images.images[0].image_id
    instance_charge_type = "PostPaid"
    instance_name        = "ecs-gh-runner1"
    instance_type        = "ecs.c3il.xlarge"
    key_pair_name        = var.key_pair_name
    project_name         = "CL-Project"
    security_group_ids   = [
        byteplus_security_group.ecs_security_group.id,
    ]
    subnet_id            = var.subnet_id
    system_volume_size   = 100
    system_volume_type   = "ESSD_PL0"
}

resource "byteplus_eip_address" "ecs_eip" {
    billing_type = "PostPaidByTraffic"
    bandwidth = 50
}

resource "byteplus_eip_associate" "ecs_eip_associate" {
    allocation_id = byteplus_eip_address.ecs_eip.id
    instance_id = byteplus_ecs_instance.ecs_jumpbox.id
    instance_type = "EcsInstance"
}