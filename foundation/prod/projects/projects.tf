resource "google_project" "wimbledon" {
  name            = "Wimbledon"
  project_id      = "ten-wimbledon-p-proj"
  folder_id       = "628139457130"
  billing_account = "015FFD-A994CD-CCE392"

  labels = {
    proj = "wimbledon"
    env  = "stage"
  }
}

resource "google_project_service" "services_wimbledon" {
  for_each                   = toset(var.wimbledon_services)
  project                    = google_project.wimbledon.id
  service                    = each.key
  disable_dependent_services = false
  disable_on_destroy         = false
  depends_on                 = [google_project.wimbledon]
}

resource "google_compute_shared_vpc_service_project" "wimbledon_vpc_service" {
  host_project    = "ten-network-p-proj"
  service_project = "ten-wimbledon-p-proj"
}

resource "google_project" "rolandgarros" {
  name            = "RolandGarros"
  project_id      = "ten-rolandgarros-p-proj"
  folder_id       = "628139457130"
  billing_account = "015FFD-A994CD-CCE392"

  labels = {
    proj = "rolandgarros"
    env  = "stage"
  }
}

resource "google_project_service" "services_rolandgarros" {
  for_each                   = toset(var.rolandgarros_services)
  project                    = google_project.rolandgarros.id
  service                    = each.key
  disable_dependent_services = false
  disable_on_destroy         = false
  depends_on                 = [google_project.rolandgarros]
}

resource "google_compute_shared_vpc_service_project" "rolandgarros_vpc_service" {
  host_project    = "ten-network-p-proj"
  service_project = "ten-rolandgarros-p-proj"
}
