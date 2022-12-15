resource "aws_s3_bucket" "this" {
  bucket = var.s3_bucket_name

  tags = merge(
    var.tags,
    {
      "Name": var.s3_bucket_name,
      "Type": "s3"
    }
  )
}