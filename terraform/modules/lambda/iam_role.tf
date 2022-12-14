resource "aws_iam_role" "this" {
  name = "iam-role-${var.lambda_function_name}"

  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "lambda.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
  EOF
}

resource "aws_iam_role_policy" "this" {
  name = "iam-role-policy-${var.lambda_function_name}"
  role = aws_iam_role.this.id

  policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "kms:Decrypt",
          "kms:GenerateDataKey",
          "s3:ListBucket",
          "s3:HeadObject",
          "s3:GetObject",
          "s3:GetObjectVersion"
        ],
        "Resource": [
          "*",
        ]
      }
    ]
  }
  EOF

  depends_on = [
    aws_iam_role.this
  ]
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this.arn

  depends_on = [
    aws_iam_role_policy.this
  ]
}