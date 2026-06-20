resource "google_cloud_run_v2_service" "app" {

  name     = var.service_name
  location = var.region

  ingress = "INGRESS_TRAFFIC_ALL"

  template {

    containers {

      image = "us-central1-docker.pkg.dev/${var.project_id}/app-repo/demo-app:latest"

    }
  }
}

resource "google_cloud_run_service_iam_member" "public" {

  location = var.region
  service  = google_cloud_run_v2_service.app.name
  role     = "roles/run.invoker"
  member   = "allUsers"

}
