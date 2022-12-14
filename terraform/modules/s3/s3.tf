resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  acl = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "aws:kms"
        kms_master_key_id = var.kms_alias_id
      }
    }
  }

  versioning {
    enabled = true
  }

  tags = merge(
    var.tags,
    {
      "Type": "S3"
    }
  )
}