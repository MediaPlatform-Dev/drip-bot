module "lambda" {
  source = "../_module/lambda"

  lambda_function_name = var.lambda_function_name
  s3_bucket_name = module.s3.s3_bucket_name

  depends_on = [
    module.s3
  ]

  tags = var.tags
}