resource "aws_s3_bucket" "this" {
  bucket = var.s3_bucket_name

  tags = merge(
    var.tags,
    {
      "Name": aws_s3_bucket.this.bucket_domain_name,
      "Type": "S3"
    }
  )
}