terraform {
  required_version = ">= 1.7.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.50.0"
    }
  }
}

provider "google" {
  project = var.project_id
}

variable "project_id" {
  type    = string
  default = "project-e1a2fa7f-d22d-462c-80e"
  validation {
    condition     = var.project_id == "project-e1a2fa7f-d22d-462c-80e"
    error_message = "This fixture belongs only to the simulated customer fixtures project."
  }
}

variable "drift_marker" {
  type    = string
  default = "baseline"
}

resource "google_storage_bucket" "private" {
  project                     = var.project_id
  name                        = "cnapp-micro-14591677-iac-live"
  location                    = "EUROPE-WEST1"
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"
  force_destroy               = false
  labels = {
    purpose      = "cnapp-fixture"
    scope        = "micro"
    runid        = "14591677"
    pillar       = "iac"
    fixture      = "sim-dsp-infra"
    state        = "pass"
    drift_marker = var.drift_marker
  }
  versioning {
    enabled = true
  }
}

output "bucket_uri" {
  value = "gs://${google_storage_bucket.private.name}"
}
