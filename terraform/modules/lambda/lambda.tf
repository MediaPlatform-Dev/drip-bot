resource "aws_lambda_function" "this" {
  function_name = var.lambda_name
  role          = aws_iam_role.this.arn

  filename = data.archive_file.lambda_zip
  source_code_hash = data.archive_file.lambda_zip

  handler = "lambda_function.lambda_handler"
  runtime = "python3.9"

  depends_on = [
    aws_iam_role.this
  ]

  tags = merge(
    var.tags,
    {
      "Name": "lambda-${var.lambda_name}",
      "Type": "lambda"
    }
  )
}