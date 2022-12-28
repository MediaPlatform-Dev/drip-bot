resource "aws_iam_role" "this" {
  name = "iam-role-${var.function_name}"

  assume_role_policy = jsonencode(
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Action": "sts:AssumeRole",
          "Principal": {
            "Service": "lambda.amazonaws.com"
          },
          "Effect": "Allow"
        }
      ]
    }
  )

  tags = merge(
    var.tags,
    {
      "Name": "iam-role-${var.function_name}",
      "Type": "role"
    }
  )
}

resource "aws_lambda_function" "this" {
  function_name = var.function_name
  role          = aws_iam_role.this.arn

  handler = var.handler
  runtime = var.runtime

  filename = "${var.function_name}.zip"
  source_code_hash = filebase64sha256("${var.function_name}.zip")

  tags = merge(
    var.tags,
    {
      "Name": var.function_name,
      "Type": "lambda"
    }
  )
}

resource "aws_lambda_function_url" "this" {
  function_name = aws_lambda_function.this.function_name
  authorization_type = "NONE"
}

