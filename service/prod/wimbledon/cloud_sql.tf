

resource "google_sql_database_instance" "wimbledon_sql_instance" {
  name             = "ten-wimbledon-p-csql-euwe2a-primary"
  database_version = "POSTGRES_15"
  region           = "europe-west2"

  settings {
    # Second-generation instance tiers are based on the machine
    # type. See argument reference below.
    tier = "db-f1-micro"

    database_flags {
      name  = "cloudsql.iam_authentication"
      value = "on"
    }

    # VPC config should be added here.
  }
}

resource "google_sql_database" "wimbledon_database" {
  name     = "wimbledon-db"
  instance = google_sql_database_instance.wimbledon_sql_instance.name
}
