module "lambda" {
  source = "../lambda"  # Adjust the path based on your directory structure
}
resource "aws_api_gateway_rest_api" "example" {
  name        = "Project_api"
  description = "Projetc API"
}

resource "aws_api_gateway_resource" "example" {
  rest_api_id = aws_api_gateway_rest_api.example.id
  parent_id   = aws_api_gateway_rest_api.example.root_resource_id
  path_part   = "example"
}

resource "aws_api_gateway_method" "example" {
  rest_api_id   = aws_api_gateway_rest_api.example.id
  resource_id   = aws_api_gateway_resource.example.id
  http_method   = "GET"
  authorization = "NONE"
}

# api_gateway/api_gateway.tf

resource "aws_api_gateway_integration" "example" {
  rest_api_id             = aws_api_gateway_rest_api.example.id
  resource_id             = aws_api_gateway_resource.example.id
  http_method             = aws_api_gateway_method.example.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = module.lambda.lambda_function_invoke_arn  // Reference Lambda function's ARN
}

resource "aws_api_gateway_deployment" "example" {
  depends_on  = [aws_api_gateway_integration.example]
  rest_api_id = aws_api_gateway_rest_api.example.id
  stage_name  = "prod"
}