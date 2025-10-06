# Terraform Demo for BytePlus VKE

This Terraform project creates a BytePlus VKE (Volcano Engine Kubernetes Engine) cluster with a VPC, subnets, a node pool, and several add-ons.

## Resources Created

*   **VPC**: A virtual private cloud with the CIDR block `172.16.0.0/16`.
*   **Subnets**: Three subnets with the following CIDR blocks:
    *   `172.16.0.0/24`
    *   `172.16.1.0/24`
    *   `172.16.2.0/24`
*   **VKE Cluster**: A Kubernetes cluster named `tf-vke-cluster`.
*   **Node Pool**: A node pool named `tf-node-pool` for the VKE cluster.
*   **ECS Key Pair**: An SSH key pair named `tf-vke-keypair` for accessing the nodes.
*   **VKE Add-ons**:
    *   CoreDNS
    *   Scheduler Plugin
    *   Metrics Server
    *   Ingress Nginx

## Prerequisites

*   Terraform installed.
*   BytePlus account and API credentials (access key and secret key).

## How to Use

1.  **Clone the repository.**
2.  **Configure your credentials**:
    Create a `terraform.tfvars` file and add your BytePlus access key and secret key:
    ```
    ak = "YOUR_ACCESS_KEY"
    sk = "YOUR_SECRET_KEY"
    ```
3.  **Initialize Terraform**:
    ```
    terraform init
    ```
4.  **Apply the configuration**:
    ```
    terraform apply
    ```

This will provision all the resources defined in the `.tf` files.

## Cleanup

To destroy all the resources created by this project, run:

```
terraform destroy
```
