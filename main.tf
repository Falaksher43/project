# main.tf

# Define variables
#variable "custom_domain_name" {
 # description = "Custom domain name for API Gateway"
#  type        = string
#}

# Define modules
module "api_gateway" {
 source             = "./api_gateway"
  #custom_domain_name = var.custom_domain_name
 lambda_arn = module.lambda.lambda_function_invoke_arn
}


module "lambda" {
  source = "./lambda"
}

module "s3_bucket" {
  source = "./s3"
}
