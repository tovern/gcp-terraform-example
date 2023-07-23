resource "google_dns_managed_zone" "tomvernon_co_uk" {
  dns_name   = "tomvernon.co.uk."
  name       = "tomvernon-co-uk"
  project    = "ten-ops-o-proj"
  visibility = "public"
}

resource "google_dns_record_set" "staging_wimbledon_tomvernon_co_uk" {
  managed_zone = google_dns_managed_zone.tomvernon_co_uk.name
  name         = "stage.${google_dns_managed_zone.tomvernon_co_uk.dns_name}"
  project      = google_dns_managed_zone.tomvernon_co_uk.project
  rrdatas      = ["1.2.3.4"]
  ttl          = "300"
  type         = "A"
}
resource "google_dns_record_set" "prod_wimbledon_tomvernon_co_uk" {
  managed_zone = google_dns_managed_zone.tomvernon_co_uk.name
  name         = "prod.${google_dns_managed_zone.tomvernon_co_uk.dns_name}"
  project      = google_dns_managed_zone.tomvernon_co_uk.project
  rrdatas      = ["4.3.2.1"]
  ttl          = "300"
  type         = "A"
}
