// root/main.tf
module "iam" {
  source = "./terraform-aws-iam"

  users = ["example_user1", "example_user2"]

  groups = ["example_group1", "example_group2"]

  group_memberships = [
    {
      group = "example_group1"
      users = ["example_user1", "example_user2"]
    }
  ]

  policies = [
    {
      name = "example_policy1"
      path = "/"
      policy = jsonencode({
        "Version" : "2012-10-17",
        "Statement" : [
          {
            "Action" : "ec2:Describe*",
            "Effect" : "Allow",
            "Resource" : "*"
          }
        ]
      })
    }
  ]

  policy_attachments = [
    {
      group      = "example_group1"
      policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
    }
  ]
}
