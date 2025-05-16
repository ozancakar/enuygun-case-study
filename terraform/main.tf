resource "google_container_cluster" "primary" {
  name     = "devops-cluster"
  location = var.region

  remove_default_node_pool = true
  initial_node_count       = 1
  deletion_protection      = false

  logging_service    = "none"
  monitoring_service = "none"

  network    = "default"
  subnetwork = "default"
}

resource "google_container_node_pool" "main_pool" {
  name     = "main-pool"
  cluster  = google_container_cluster.primary.name
  location = var.region

  node_config {
    machine_type = "n2d-standard-2"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  initial_node_count = 0

  autoscaling {
    min_node_count = 0
    max_node_count = 1
  }
}

resource "google_container_node_pool" "app_pool" {
  name     = "application-pool"
  cluster  = google_container_cluster.primary.name
  location = var.region

  node_config {
    machine_type = "n2d-standard-2"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
    labels = {
      role = "app"
    }
  }

  initial_node_count = 1

  autoscaling {
    min_node_count = 1
    max_node_count = 3
  }
}
