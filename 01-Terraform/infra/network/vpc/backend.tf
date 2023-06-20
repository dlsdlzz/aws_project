terraform {
  backend "s3"{
    bucket = "aws03-terraform-state"
    key = "infra/network/vpc/terraform.tfstate"
    region = "ap-northeast-2"

    dynamodb_table = "aws03-terraform-locks"
    encrypt = true
  }
}