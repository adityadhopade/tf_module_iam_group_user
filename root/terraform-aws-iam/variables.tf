// terraform-aws-iam/variables.tf
variable "users" {
  description = "List of IAM users"
  type        = list(string)
}

variable "groups" {
  description = "List of IAM groups"
  type        = list(string)
}

variable "group_memberships" {
  description = "List of group memberships"
  type = list(object({
    group = string
    users = list(string)
  }))
}

variable "policies" {
  description = "List of IAM policies"
  type = list(object({
    name   = string
    path   = string
    policy = string
  }))
}

variable "policy_attachments" {
  description = "List of policy attachments"
  type = list(object({
    group      = string
    policy_arn = string
  }))
}
