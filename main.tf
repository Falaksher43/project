module "api_gateway" {
  source = "./api_gateway"
}
module "lambda" {
  source = "./lambda"
}
module "s3_bucket" {
  source = "./s3"
}
