resource "google_cloud_run_v2_service" "api1_service" {
  name     = "ten-wimbledon-s-crs-euwe2a-api1"
  location = "europe-west2"
  ingress  = "INGRESS_TRAFFIC_ALL"

  template {

    service_account = "wimbledown-api1-sa@ten-wimbledon-s-proj.iam.gserviceaccount.com"

    scaling {
      min_instance_count = 1
      max_instance_count = 2
    }

    volumes {
      name = "cloudsql"
      cloud_sql_instance {
        instances = [
          "ten-wimbledon-s-proj:europe-west2:ten-wimbledon-s-csql-euwe2a-primary",
        ]
      }
    }

    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"

      volume_mounts {
        mount_path = "/cloudsql"
        name       = "cloudsql"
      }
      resources {
        cpu_idle = true
        limits = {
          "cpu"    = "1000m"
          "memory" = "512Mi"
        }
      }
    }
  }

  labels = {
    app  = "api2"
    proj = "wimbledon"
    env  = "stage"
  }

}

resource "google_cloud_run_service_iam_binding" "api1_service_access" {
  location = google_cloud_run_v2_service.api1_service.location
  service  = google_cloud_run_v2_service.api1_service.name
  role     = "roles/run.invoker"
  members = [
    "group:platform-engineering@tomvernon.co.uk",
    "group:wimbledon-software-engineering@tomvernon.co.uk"
  ]
}

resource "google_cloud_run_v2_service" "api2_service" {
  name     = "ten-wimbledon-s-crs-euwe2a-api2"
  location = "europe-west2"
  ingress  = "INGRESS_TRAFFIC_ALL"

  template {

    service_account = "wimbledown-api2-sa@ten-wimbledon-s-proj.iam.gserviceaccount.com"

    scaling {
      min_instance_count = 1
      max_instance_count = 2
    }

    volumes {
      name = "cloudsql"
      cloud_sql_instance {
        instances = [
          "ten-wimbledon-s-proj:europe-west2:ten-wimbledon-s-csql-euwe2a-primary",
        ]
      }
    }

    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"

      volume_mounts {
        mount_path = "/cloudsql"
        name       = "cloudsql"
      }
      resources {
        cpu_idle = true
        limits = {
          "cpu"    = "1000m"
          "memory" = "512Mi"
        }
      }
    }
  }

  labels = {
    app  = "api2"
    proj = "wimbledon"
    env  = "stage"
  }

}

resource "google_cloud_run_service_iam_binding" "api2_service_access" {
  location = google_cloud_run_v2_service.api2_service.location
  service  = google_cloud_run_v2_service.api2_service.name
  role     = "roles/run.invoker"
  members = [
    "group:platform-engineering@tomvernon.co.uk",
    "group:wimbledon-software-engineering@tomvernon.co.uk"
  ]
}

resource "google_cloud_run_v2_service" "web_service" {
  name     = "ten-wimbledon-s-crs-euwe2a-web"
  location = "europe-west2"
  ingress  = "INGRESS_TRAFFIC_ALL"

  template {

    service_account = "wimbledown-web-sa@ten-wimbledon-s-proj.iam.gserviceaccount.com"

    scaling {
      min_instance_count = 1
      max_instance_count = 2
    }

    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"

      resources {
        cpu_idle = true
        limits = {
          "cpu"    = "1000m"
          "memory" = "512Mi"
        }
      }
    }
  }

  labels = {
    app  = "web"
    proj = "wimbledon"
    env  = "stage"
  }

}

resource "google_cloud_run_service_iam_binding" "web_service_access" {
  location = google_cloud_run_v2_service.web_service.location
  service  = google_cloud_run_v2_service.web_service.name
  role     = "roles/run.invoker"
  members = [
    "group:platform-engineering@tomvernon.co.uk",
    "group:wimbledon-software-engineering@tomvernon.co.uk"
  ]
}
