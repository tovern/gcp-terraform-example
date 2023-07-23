# Prevent auto creation of VPC networks in new projects

resource "google_folder_organization_policy" "skip_network" {
  folder     = data.google_folder.tennisinc.id
  constraint = "constraints/compute.skipDefaultNetworkCreation"

  boolean_policy {
    enforced = true
  }
}