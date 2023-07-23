resource "google_storage_bucket" "terraform_state_bucket" {
  name                        = "ten-ops-o-gsb-terraform-state"
  project                     = "ten-ops-o-proj"
  storage_class               = "REGIONAL"
  location                    = "us-west1"
  force_destroy               = "true"
  uniform_bucket_level_access = true

  depends_on = [
    google_project.ops
  ]

  labels = {
    proj = "ops"
    env  = "common"
  }

}
