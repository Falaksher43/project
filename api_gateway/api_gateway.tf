#module "lambda" {
  #source = "../lambda"  # Adjust the path based on your directory structure
#}

resource "aws_api_gateway_rest_api" "example" {
  name        = "Project_api"
  description = "Project API"
}
#################################


resource "aws_api_gateway_resource" "example" {
  rest_api_id = aws_api_gateway_rest_api.example.id
  parent_id   = aws_api_gateway_rest_api.example.root_resource_id
  path_part   = "example"
}

resource "aws_api_gateway_method" "example" {
  rest_api_id   = aws_api_gateway_rest_api.example.id
  resource_id   = aws_api_gateway_resource.example.id
  http_method   = "ANY"
  authorization = "NONE"
}
##################

# Define the API Gateway integration
resource "aws_api_gateway_integration" "lambda" {
 # depends_on = [module.lambda]
  rest_api_id             = aws_api_gateway_rest_api.example.id
  resource_id             = aws_api_gateway_method.example.resource_id
  http_method             = aws_api_gateway_method.example.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_arn  // Reference Lambda function's ARN
}
######################
resource "aws_api_gateway_method" "proxy_root" {
  rest_api_id   = aws_api_gateway_rest_api.example.id
  resource_id   = aws_api_gateway_rest_api.example.root_resource_id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_root" {
  rest_api_id = aws_api_gateway_rest_api.example.id
  resource_id = aws_api_gateway_method.proxy_root.resource_id
  http_method = aws_api_gateway_method.proxy_root.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_arn
}
# Define the base path mapping
resource "aws_api_gateway_base_path_mapping" "custom_domain_mapping" {
  depends_on   = [aws_api_gateway_deployment.example]
  api_id       = aws_api_gateway_rest_api.example.id
  stage_name   = aws_api_gateway_deployment.example.stage_name
  domain_name  = var.custom_domain_name // Replace with your custom domain
}
###############################


resource "aws_api_gateway_deployment" "example" {
  depends_on = [
    aws_api_gateway_integration.lambda,
    aws_api_gateway_integration.lambda_root,
  ]
  
  rest_api_id = aws_api_gateway_rest_api.example.id
  stage_name  = "prod"
}
