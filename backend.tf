terraform {
  backend "s3" {
    bucket  = "lab2-test-bucket"
    key     = "terraform.tfstate"
    region  = "us-east-1"
    profile = "default"
  }
}
