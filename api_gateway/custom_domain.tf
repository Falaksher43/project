resource "aws_api_gateway_domain_name" "example" {
  domain_name              = var.custom_domain_name
  endpoint_configuration {
    types = ["REGIONAL"]  # Use regional endpoint configuration
  }

  tags = {
    Name = "CustomDomain"
  }
}

resource "aws_api_gateway_base_path_mapping" "example" {
  api_id       = aws_api_gateway_rest_api.example.id
  stage_name   = aws_api_gateway_deployment.example.stage_name
  domain_name  = aws_api_gateway_domain_name.example.domain_name
}