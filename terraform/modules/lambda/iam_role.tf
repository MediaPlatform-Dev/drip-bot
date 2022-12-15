resource "aws_iam_role" "this" {
  name = "iam-role-${var.lambda_function_name}"

  assume_role_policy = jsonencode(
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
  )

  tags = merge(
    var.tags,
    {
      "Name": aws_iam_role.this.name,
      "Type": "role"
    })
}

resource "aws_iam_policy" "this" {
  name = "iam-policy-${var.lambda_function_name}"

  policy = jsonencode(
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Action": [
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
  )

  depends_on = [
    aws_iam_role.this
  ]

  tags = merge(
    var.tags,
    {
      "Name": aws_iam_policy.this.name,
      "Type": "policy"
    })
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this.arn

  depends_on = [
    aws_iam_policy.this
  ]
}