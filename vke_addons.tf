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
  deploy_mode = "Managed"
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