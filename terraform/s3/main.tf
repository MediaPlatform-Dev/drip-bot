module "s3" {
  source = "./modules/s3"
  s3_bucket_name = var.s3_bucket_name

  tags = var.tags
}