# Synthetic Terraform with deliberate defects. Never applied.

# Defect: no server-side encryption configuration, no public access block,
# and a public-read ACL.
resource "aws_s3_bucket" "bid_logs" {
  bucket = "sim-dsp-bid-logs-example"
}

resource "aws_s3_bucket_acl" "bid_logs" {
  bucket = aws_s3_bucket.bid_logs.id
  acl    = "public-read"
}

# Defect: SSH reachable from the whole internet.
resource "aws_security_group" "bidder" {
  name        = "sim-dsp-bidder"
  description = "Synthetic bidder security group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Defect: uniform bucket-level access disabled, no public access prevention.
resource "google_storage_bucket" "reports" {
  name                        = "sim-dsp-reports-example"
  location                    = "EU"
  uniform_bucket_level_access = false
}

# Compliant counterpart for contrast.
resource "google_storage_bucket" "archive" {
  name                        = "sim-dsp-archive-example"
  location                    = "EU"
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"
}
