resource "google_compute_region_network_endpoint_group" "neg_api1" {
  name                  = "ten-wimbledon-q-neg-euwe2a-api1"
  network_endpoint_type = "SERVERLESS"
  region                = "europe-west2"
  cloud_run {
    service = google_cloud_run_v2_service.api1_service.name
  }
}

resource "google_compute_region_network_endpoint_group" "neg_api2" {
  name                  = "ten-wimbledon-q-neg-euwe2a-api2"
  network_endpoint_type = "SERVERLESS"
  region                = "europe-west2"
  cloud_run {
    service = google_cloud_run_v2_service.api2_service.name
  }
}

resource "google_compute_region_network_endpoint_group" "neg_web" {
  name                  = "ten-wimbledon-q-neg-euwe2a-web"
  network_endpoint_type = "SERVERLESS"
  region                = "europe-west2"
  cloud_run {
    service = google_cloud_run_v2_service.web_service.name
  }
}

module "alb_ingress" {
  source         = "GoogleCloudPlatform/lb-http/google//modules/serverless_negs"
  version        = "~> 9.0"
  name           = "ten-wimbledon-q-alb-euwe2a-ingress"
  project        = var.project_id
  url_map        = google_compute_url_map.routing_map.self_link
  create_url_map = true
  ssl            = true
  #certificate_map = ["staging-wimbledon-cert"]
  managed_ssl_certificate_domains = [var.domain]

  https_redirect = true

  backends = {
    api1backend = {
      description = null
      groups = [
        {
          group = google_compute_region_network_endpoint_group.neg_api1.id
        }
      ]
      enable_cdn              = false
      security_policy         = null
      custom_request_headers  = null
      custom_response_headers = null
      iap_config = {
        enable               = false
        oauth2_client_id     = ""
        oauth2_client_secret = ""
      }
      log_config = {
        enable      = false
        sample_rate = null
      }
      protocol         = "HTTP"
      port_name        = null
      compression_mode = null
    }

    api2backend = {
      description = null
      groups = [
        {
          group = google_compute_region_network_endpoint_group.neg_api2.id
        }
      ]
      enable_cdn              = false
      security_policy         = null
      custom_request_headers  = null
      custom_response_headers = null

      iap_config = {
        enable               = false
        oauth2_client_id     = ""
        oauth2_client_secret = ""
      }
      log_config = {
        enable      = false
        sample_rate = null
      }
      protocol         = null
      port_name        = null
      compression_mode = null
    }

    web = {
      description = null
      groups = [
        {
          group = google_compute_region_network_endpoint_group.neg_web.id
        }
      ]
      enable_cdn              = false
      security_policy         = null
      custom_request_headers  = null
      custom_response_headers = null

      iap_config = {
        enable               = false
        oauth2_client_id     = ""
        oauth2_client_secret = ""
      }
      log_config = {
        enable      = false
        sample_rate = null
      }
      protocol         = null
      port_name        = null
      compression_mode = null
    }
  }

  labels = {
    proj = "wimbledon"
    env  = "stage"
  }

}

resource "google_compute_url_map" "routing_map" {
  name            = "ten-wimbledon-q-alb-euwe2a-map"
  default_service = module.alb_ingress.backend_services["web"].self_link

  host_rule {
    hosts        = ["*"]
    path_matcher = "allpaths"
  }

  path_matcher {
    name            = "allpaths"
    default_service = module.alb_ingress.backend_services["web"].self_link

    path_rule {
      paths = [
        "/api1",
        "/api1/*"
      ]
      service = module.alb_ingress.backend_services["api1backend"].self_link
    }

    path_rule {
      paths = [
        "/api2",
        "/appi/*"
      ]
      service = module.alb_ingress.backend_services["api2backend"].self_link
    }
  }
}
