resource "google_compute_instance" "chewbacca_vm" {
  name         = var.vm_name
  machine_type = "n2-standard-2"
  zone         = var.zone

  tags = ["http-server"]

  boot_disk {
    initialize_params {
      image = "projects/centos-cloud/global/images/family/centos-stream-10"
      size  = 100
    }
  }

  network_interface {
    network = "default"

    access_config {
      # external IP enabled
    }
  }

  metadata_startup_script = file("${path.module}/startup.sh")
}
