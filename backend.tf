terraform {
  backend "s3" {
    bucket  = "ort-terraform"
    key     = "terraform/backend.tfstate"
    region  = "ap-northeast-1"
    profile = "ort"
  }
}
