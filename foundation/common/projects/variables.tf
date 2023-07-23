variable "network_services" {
  type = list(any)
  default = [
    "compute.googleapis.com"
  ]
}
