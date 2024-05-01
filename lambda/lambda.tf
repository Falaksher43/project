resource "random_id" "role_suffix" {
  byte_length = 4
}

resource "aws_iam_role" "lambda_exec" {
  name = "example_lambda_role-${random_id.role_suffix.hex}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_lambda_function" "lambda-function" {
  function_name = "example_lambda_function"  // Name of existing Lambda function
  role          = aws_iam_role.lambda_exec.arn
  handler       = "handler.lambda_handler"
  runtime       = "python3.8"
  filename      = "${path.module}/handler.py.zip"  // Path to your updated Lambda function code
  // Other attributes...
}
