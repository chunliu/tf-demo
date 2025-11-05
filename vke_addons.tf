# CoreDNS Addon
resource "byteplus_vke_addon" "tf_vke_addon_dns" {
  cluster_id = byteplus_vke_cluster.vke_cluster.id
  name = "core-dns"
  config = jsonencode(
    {
      Resources = {
        Limits = {
          Cpu = "1"
          Memory = "2Gi"
        }
        Requests = {
          Cpu = "0.2"
          Memory = "1Gi"
        }
      }
    }
  )
  # deploy_mode = "Managed"
}
# Scheduler Addon
resource "byteplus_vke_addon" "tf_vke_addon_scheduler" {
  cluster_id = byteplus_vke_cluster.vke_cluster.id
  name = "scheduler-plugin"
  config = jsonencode(
      {
          GPUShareCardPolicy              = "binpack"
          GangSchedulingEnabled           = false
          LoadAwareSchedulingEnabled      = false
          NodeAffinityWeight              = 2
          NodePolicy                      = "spread"
          PodTopologySpreadWeight         = 2
          RdmaTopologySchedulingEnabled   = false
          ResourcePolicySchedulingEnabled = false
          ResourceWeights                 = [
              {
                  Name   = "Cpu"
                  Weight = 1
              },
              {
                  Name   = "Memory"
                  Weight = 1
              },
          ]
      }
  )
  deploy_mode = "Managed"
}
# Metrics Addon
resource "byteplus_vke_addon" "tf_vke_addon_metrics" {
  cluster_id = byteplus_vke_cluster.vke_cluster.id
  name = "metrics-server"
}

resource "byteplus_vke_addon" "tf_vke_addon_ingress_nginx" {
  cluster_id = byteplus_vke_cluster.vke_cluster.id
  name = "ingress-nginx"
  config = jsonencode(
      {
        LoadBalancer   = {
            BillingType                    = 2
            MasterZoneId                   = "ap-southeast-1a"
            ModificationProtectionDisabled = false
            SlaveZoneId                    = "ap-southeast-1b"
            Spec                           = "small_1"
        }
        # For private network
        # PrivateNetwork = {
        #     IpFamily = "Ipv4"
        #     SubnetId = byteplus_subnet.tf_subnet2.id
        # }
        # For public network
        PublicNetwork = {
            BandWidth   = 50
            BillingType = 3
            IpFamily    = "Ipv4"
            Isp         = "BGP"
            SubnetId    = byteplus_subnet.tf_subnet3.id
        }        
        Replicas       = 2
        Resources      = {
            Limits   = {
                Cpu    = "0.5"
                Memory = "1024Mi"
            }
            Requests = {
                Cpu    = "0.1"
                Memory = "250Mi"
            }
        }
      }
  )
}

resource "byteplus_vke_addon" "tf_vke_addon_cr" {
  cluster_id = byteplus_vke_cluster.vke_cluster.id
  name = "cr-credential-controller"
  config = jsonencode(
    {
      CrConfigmapData = {
          Namespace      = "*"
          Registries     = [
              {
                  Domains  = var.cr_domains
                  Instance = var.cr_instance
                  Region   = "ap-southeast-1"
              },
          ]
          ServiceAccount = "*"
      }
    }
  )
}