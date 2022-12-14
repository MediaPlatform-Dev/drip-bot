resource "aws_iam_policy" "this" {
  description = "IAM Policy"
  name = "iam-policy-${var.lambda_function_name}"

  policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
              "Effect": "Allow",
              "Action": [
                  "s3:ListAllMyBuckets",
                  "s3:GetBucketLocation"
              ],
              "Resource": "*"
          },
          {
              "Effect": "Allow",
              "Action": "s3:*",
              "Resource": [
                  "arn:aws:s3:::${var.s3_bucket_name}",
                  "arn:aws:s3:::${var.s3_bucket_name}/*"
              ]
          },
          {
            "Action": [
              "autoscaling:Describe*",
              "cloudwatch:*",
              "logs:*",
              "sns:*"
            ],
            "Effect": "Allow",
            "Resource": "*"
          }
    ]
  }
  EOF
}

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

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this.arn

  depends_on = [
    aws_iam_policy.this,
    aws_iam_role.this
  ]
}