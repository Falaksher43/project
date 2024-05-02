resource "aws_api_gateway_domain_name" "example" {
  for_each    = toset(var.custom_domain_name != null ? ["true"] : [])
  domain_name              = var.custom_domain_name
  regional_certificate_arn = var.regional_arn
  endpoint_configuration {
    types = ["REGIONAL"]  # Use regional endpoint configuration
  }

  tags = {
    Name = "CustomDomain"
  }
}

resource "aws_api_gateway_base_path_mapping" "example" {
  for_each    = toset(var.custom_domain_name != null ? ["true"] : [])
  api_id       = aws_api_gateway_rest_api.example.id
  stage_name   = aws_api_gateway_deployment.example.stage_name
  
  domain_name  = aws_api_gateway_domain_name.example["true"].domain_name
}