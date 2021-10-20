provider "aws" {
  region  = "ap-northeast-1"
  profile = "ort"
}

# provider for us-east-1
provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}

/* 使用時の AWS Account ID */
data "aws_caller_identity" "self" {}
