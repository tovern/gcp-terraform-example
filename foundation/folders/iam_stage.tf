resource "google_folder_iam_binding" "stage_owner" {
  folder = google_folder.stage.name
  members = [
    "group:platform-engineering@tomvernon.co.uk"
  ]
  role = "roles/owner"
}
