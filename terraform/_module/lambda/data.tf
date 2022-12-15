data "archive_file" "this" {
  source_dir  = "${path.module}/python/"
  output_path = "${path.module}/${var.lambda_function_name}.zip"
  type        = "zip"
}