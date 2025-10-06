# Create a VKE cluster
resource "byteplus_vke_cluster" "vke_cluster" {
  name = "tf-vke-cluster"
  kubernetes_version = "1.30"
  description = "a vke cluster created by terraform"
  delete_protection_enabled = false
  cluster_config {
    subnet_ids = [byteplus_subnet.tf_subnet1.id]
    api_server_public_access_enabled = false
    resource_public_access_default_enabled = true
  }
  pods_config {
    pod_network_mode = "VpcCniShared"
    vpc_cni_config {
      subnet_ids = [byteplus_subnet.tf_subnet2.id]
    }
  }
  services_config {
    service_cidrsv4 = ["192.168.16.0/24"]
  }
}

resource "byteplus_ecs_key_pair" "tf_keypair" {
  key_pair_name = "tf-vke-keypair"
}

resource "byteplus_vke_node_pool" "vke_node_pool" {
  cluster_id = byteplus_vke_cluster.vke_cluster.id
  name = "tf-node-pool"
  node_config {
    instance_type_ids = ["ecs.g3il.large"]
    subnet_ids = [byteplus_subnet.tf_subnet1.id]
    security {
      login {
        ssh_key_pair_name = byteplus_ecs_key_pair.tf_keypair.key_pair_name
      }
    }
    system_volume {
      type = "ESSD_PL0"
      size = 40
    }
  }
  kubernetes_config {
    cordon = false
  }
  auto_scaling {
    enabled = false
    min_replicas = 1
    max_replicas = 3
    desired_replicas = 1
  }
}
