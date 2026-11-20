# Copy as backend.tf in the customer repository after the AM-04 apply.
# The reviewed fixture route deliberately keeps local state until that apply.
terraform {
  backend "gcs" {
    bucket = "cnapp-micro-14591677-iac-live"
    prefix = "sim-dsp-infra/private-bucket"
  }
}
