# Example GCP Terraform Setup

This example, inspired by https://simplifymy.cloud/ breaks the environment into three layers; foundation, service, application

Splitting the infrastructure into layers enables better separation of responsibilities, enforces policy and reduces the blast radius of any changes that are made.

# Foundation

Allows security settings and structure to be enforced from the top level:

- Folders
- Projects
- Network
- IAM

# Service

Allows hosted services to be deployed ontop of the secure foundation. These services are dependencies of the applications.

- Cloud SQL
- Buckets
- GKE
- Cloud Run AServices

# Application

The application layer allows deployment of the applications on top of the already secure foundation, with all of the service dependencies already provisioned. This would usually be managed outside of Terraform, for example using the CI/CD pipeline or another Git repository.

