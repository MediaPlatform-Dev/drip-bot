module "kms" {
  source = "../_module/kms"
  kms_alias_name = var.s3_bucket_name

  tags = var.tags
}

module "s3" {
  source = "../_module/s3"
  s3_bucket_name = var.s3_bucket_name
  kms_alias_id = module.kms.kms_alias_id

  tags = var.tags
}