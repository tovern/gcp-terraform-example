resource "google_folder" "tennisinc" {
  display_name = "tennisinc"
  parent       = "organizations/669999103443"
}

resource "google_folder" "prod" {
  display_name = "prod"
  parent       = google_folder.tennisinc.name
}

resource "google_folder" "stage" {
  display_name = "stage"
  parent       = google_folder.tennisinc.name
}

resource "google_folder" "common" {
  display_name = "common"
  parent       = google_folder.tennisinc.name
}