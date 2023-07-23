resource "google_folder_iam_binding" "common_owner" {
  folder = google_folder.common.name
  members = [
    "group:platform-engineering@tomvernon.co.uk"
  ]
  role = "roles/owner"
}
