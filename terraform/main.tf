resource "aws_lambda_function" "reaction_bot" {
  function_name = "reaction_bot"
  role          = ""
  handler = "lambda_function.lambda_handler"
  runtime = "python3.9"
}