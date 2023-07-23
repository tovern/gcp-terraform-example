resource "google_project_iam_binding" "cloudsql_client_role" {
  role    = "roles/cloudsql.client"
  project = var.project_id
  members = [
    "serviceAccount:${google_service_account.wimbledon_api1_sa.email}",
    "serviceAccount:${google_service_account.wimbledon_api2_sa.email}"
  ]
}

resource "google_project_iam_binding" "cloudsql_instanceuser_role" {
  role    = "roles/cloudsql.instanceUser"
  project = var.project_id
  members = [
    "serviceAccount:${google_service_account.wimbledon_api1_sa.email}",
    "serviceAccount:${google_service_account.wimbledon_api2_sa.email}"
  ]
}

resource "google_service_account" "wimbledon_api1_sa" {
  account_id  = "wimbledown-api1-sa"
  description = "Wimbledon API1 SA"
}

resource "google_service_account" "wimbledon_api2_sa" {
  account_id  = "wimbledown-api2-sa"
  description = "Wimbledon API2 SA"
}

resource "google_service_account" "wimbledon_web_sa" {
  account_id  = "wimbledown-web-sa"
  description = "Wimbledon web SA"
}
