variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
}

variable "aws_access_key" {
  description = "AWS access key ID"
  type        = string
}

variable "aws_secret_key" {
  description = "AWS secret access key"
  type        = string
}


#variable "custom_domain_name" {
# description = "Custom domain name for API Gateway"
#}
variable "create_lambda" {
  description = "Flag to control whether to create the Lambda function"
  type        = bool
  default     = true
}
