terraform {
  backend "gcs" {
    bucket = "ten-ops-o-gsb-terraform-state"
    prefix = "terraform/service/prod/wimledon"
  }
}
