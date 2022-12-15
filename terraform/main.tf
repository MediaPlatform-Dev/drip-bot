module "s3" {
  source = "./modules/s3"

  s3_bucket_name = var.lambda_function_name

  tags = var.tags
}

module "lambda" {
  source = "./modules/lambda"

  lambda_function_name = var.lambda_function_name
  s3_bucket_name = module.s3.s3_bucket_name

  depends_on = [
    module.s3
  ]

  tags = var.tags
}