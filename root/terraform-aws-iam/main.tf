terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.57.0"
    }
  }
}

// terraform-aws-iam/main.tf
resource "aws_iam_user" "users" {
  count = length(var.users)
  name  = var.users[count.index]
}

resource "aws_iam_group" "groups" {
  count = length(var.groups)
  name  = var.groups[count.index]

  // Ensure users are removed from groups before deleting the group
  depends_on = [
    aws_iam_group_membership.group_memberships
  ]
}

# manages membership of iam users within IAM groups
resource "aws_iam_group_membership" "group_memberships" {
  count = length(var.group_memberships)
  name  = "${var.group_memberships[count.index].group}_membership"
  #list of users to be added to the group
  users = var.group_memberships[count.index].users
  # iam group to whihc the users will be added
  group = var.group_memberships[count.index].group
}

resource "aws_iam_policy" "policies" {
  count  = length(var.policies)
  name   = var.policies[count.index].name
  path   = var.policies[count.index].path
  policy = var.policies[count.index].policy
}

# attaching IAM policies to IAM Groups
resource "aws_iam_group_policy_attachment" "policy_attachments" {
  count      = length(var.policy_attachments)
  group      = var.policy_attachments[count.index].group
  policy_arn = var.policy_attachments[count.index].policy_arn
}
