# Terraform for VKE Cluster

This Terraform project sets up a VKE (Volcano Engine Kubernetes Engine) cluster on BytePlus.

## Features

- Creates a VPC and subnets.
- Deploys a VKE cluster with a specified Kubernetes version.
- Configures a node pool with auto-scaling capabilities.
- Installs essential add-ons:
    - CoreDNS for service discovery.
    - Scheduler for pod scheduling.
    - Metrics Server for resource metrics.
    - CR Credential Controller for container registry integration.
    - VCI Virtual Kubelet.
- Optionally creates:
    - An NGINX Ingress controller.
    - An ECS jumpbox for accessing the cluster.

## Prerequisites

- Terraform v1.0 or later.
- A BytePlus account.

## Usage

1. **Configure your BytePlus credentials:**

   Create a `terraform.tfvars` file and add your access key and secret key:

   ```tfvars
   ak = "YOUR_BYTEPLUS_ACCESS_KEY"
   sk = "YOUR_BYTEPLUS_SECRET_KEY"
   ```

2. **Initialize Terraform:**

   ```bash
   terraform init
   ```

3. **Apply the Terraform configuration:**

   ```bash
   terraform apply
   ```

   You will be prompted to confirm the resources to be created.

4. **(Optional) Enable NGINX Ingress and Jumpbox:**

   You can enable the creation of the NGINX ingress and the jumpbox by setting the corresponding variables in your `terraform.tfvars` file:

   ```tfvars
   create_nginx_ingress = true
   create_jumpbox      = true
   ```

## Modules

- **`ecs_jumpbox`**: This module creates an ECS instance that can be used as a jumpbox to access the VKE cluster.

## Resources

- `byteplus_vpc`
- `byteplus_subnet`
- `byteplus_vke_cluster`
- `byteplus_vke_node_pool`
- `byteplus_vke_addon`
- `byteplus_ecs_key_pair`
- `byteplus_ecs_instance`
- `byteplus_eip_address`
- `byteplus_eip_associate`
- `byteplus_security_group`