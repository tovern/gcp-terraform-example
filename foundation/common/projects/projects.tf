resource "google_project" "ops" {
  name            = "Ops Project"
  project_id      = "ten-ops-o-proj"
  folder_id       = "685970739481"
  billing_account = "015FFD-A994CD-CCE392"

  labels = {
    proj = "ops"
    #env  = ""
  }
}

resource "google_project" "backup" {
  name            = "Backup Project"
  project_id      = "ten-backup-o-proj"
  folder_id       = "685970739481"
  billing_account = "015FFD-A994CD-CCE392"

  labels = {
    proj = "backup"
    #env  = ""
  }
}

resource "google_project" "logging" {
  name            = "Logging Project"
  project_id      = "ten-logging-o-proj"
  folder_id       = "685970739481"
  billing_account = "015FFD-A994CD-CCE392"

  labels = {
    proj = "logging"
    #env  = ""
  }
}

resource "google_project" "artefacts" {
  name            = "Artefact Project"
  project_id      = "ten-artefacts-o-proj"
  folder_id       = "685970739481"
  billing_account = "015FFD-A994CD-CCE392"

  labels = {
    proj = "artefacts"
    #env  = ""
  }
}

resource "google_project" "network_prod" {
  name            = "network-prod Project"
  project_id      = "ten-network-p-proj"
  folder_id       = "685970739481"
  billing_account = "011F7C-A7BC23-980215"

  labels = {
    proj = "network-prod"
    #env  = ""
  }
}

# A host project provides network resources to associated service projects.
resource "google_compute_shared_vpc_host_project" "host_prod" {
  project = google_project.network_prod.number
}

resource "google_project_service" "services_prod" {
  for_each                   = toset(var.network_services)
  project                    = google_project.network_prod.id
  service                    = each.key
  disable_dependent_services = false
  disable_on_destroy         = false
  depends_on                 = [google_project.network_prod]
}

resource "google_project" "network_stage" {
  name            = "network-stage Project"
  project_id      = "ten-network-s-proj"
  folder_id       = "685970739481"
  billing_account = "011F7C-A7BC23-980215"

  labels = {
    proj = "network-stage"
    #env  = ""
  }
}

# A host project provides network resources to associated service projects.
resource "google_compute_shared_vpc_host_project" "host_stage" {
  project = google_project.network_stage.number
}

resource "google_project_service" "services_stage" {
  for_each                   = toset(var.network_services)
  project                    = google_project.network_stage.id
  service                    = each.key
  disable_dependent_services = false
  disable_on_destroy         = false
  depends_on                 = [google_project.network_stage]
}
