
variable "custom_domain_name" {
  description = "The custom domain name for API Gateway"
  type        = string
  default = null
}

variable "lambda_arn" {
    description = "lambda function"
    type = string     
}
variable "acm_arn" {
    description = "acm arn detail"
    type = string
    default = null
}
variable "regional_arn" {
  description = "value"
  default = null
}