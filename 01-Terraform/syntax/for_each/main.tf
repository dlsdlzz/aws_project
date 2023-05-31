provider "aws" {
	region = "ap-northeast-2"
}

resource "aws_iam_user" "example" {
	for_each = toset(var.user_names)
	name  = each.value
}

variable "user_names" {
	description = "Create IAM with these names"
	type				= list(string)
	default = ["aws03-neo","aws03-trinity","aws03-morpheus"]
}

output "all_user" {
	value       = values(aws_iam_user.example)[*].arn
	description = "The name for all users"
}
