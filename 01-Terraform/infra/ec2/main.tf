terraform {
	required_version = ">=1.0.0, < 2.0.0"

	required_providers {
		aws = {
			source = "hashicorp/aws"
			version = "~> 4.0"
		}
	}

	backend "s3" {
		bucket = "aws03-terraform-state"
		key = "infra/ec2/terraform.tfstate"
		region = "ap-northeast-2"

		dynamodb_table = "aws03-terraform-locks"
		encrypt = true
	}
}

