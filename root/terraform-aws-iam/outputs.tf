// terraform-aws-iam/outputs.tf
output "user_names" {
  value = aws_iam_user.users[*].name
}

output "group_names" {
  value = aws_iam_group.groups[*].name
}

output "policy_arns" {
  value = aws_iam_policy.policies[*].arn
}
