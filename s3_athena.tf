resource "aws_s3_bucket" "athena-cache-nidanakavi" {
  bucket = "ece592-athena-cache-nidanakavi"
  acl    = "private"

  tags = {
    Name = "ece592-athena-cache-nidanakavi"
  }

  # Keep old versions of the state file.
  versioning {
    enabled = true
  }

  # Transition old versions to cheaper storage after 30 days.
  lifecycle_rule {
    enabled = true
    tags    = {}

    noncurrent_version_transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
  }

  # Encryption at rest using default AWS keys!
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

