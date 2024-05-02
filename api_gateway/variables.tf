# Create a file named variables.tf (or any suitable name) to define your variables

#variable "custom_domain_name" {
  #description = "The custom domain name for your API Gateway"
 # type        = string
  # You can also specify a default value if needed
  # default     = "example.com"
#}
variable "custom_domain_name" {
  description = "The custom domain name for API Gateway"
  type        = string
}

variable "lambda_arn" {
    description = "lambda function"
    type = string     
}