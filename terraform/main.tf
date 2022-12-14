module "kms" {
  source = "modules/kms"

  alias_name = var.lambda_function_name

  tags = var.tags
}


module "s3" {
  source = "modules/s3"

  bucket_name = var.lambda_function_name
  kms_alias_id = module.kms.kms_alias_id

  depends_on = [
    module.kms
  ]

  tags = var.tags
}

module "lambda" {
  source = "modules/lambda"

  lambda_function_name = var.lambda_function_name
  s3_bucket_name = module.s3.bucket_name

  depends_on = [
    module.s3
  ]

  tags = var.tags
}