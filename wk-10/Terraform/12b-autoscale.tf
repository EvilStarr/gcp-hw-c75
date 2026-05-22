resource "google_compute_autoscaler" "default2" {

  name     = "tokyo-autoscaler"
  zone     = var.region_b
  target   = google_compute_instance_group_manager.tokyo-mig.id
  provider = google-beta

  autoscaling_policy {
    max_replicas    = 5
    min_replicas    = 1
    cooldown_period = 60


    cpu_utilization {
      target = 0.6
    }
  }
}
