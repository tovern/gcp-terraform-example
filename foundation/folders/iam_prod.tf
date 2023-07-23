resource "google_folder_iam_binding" "prod_owner" {
  folder = google_folder.prod.name
  members = [
    "group:platform-engineering@tomvernon.co.uk"
  ]
  role = "roles/owner"
}
