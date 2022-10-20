variable "region" {
    type = string
    default = ""
}
variable "profile" {
    type = string
    default = ""
}
variable "name" {
    description = "The Grafana Workspce name"
    type = string
    default = ""
}

variable "account_access_type" {
    type = string
    default = ""
}

variable "authentication_providers" {
    type = list(string)
    default = [""]
}

variable "permission_type" {
    type = string
    default = ""
}

variable "Admin_permission" {
    type = string
    default = ""
}

variable "aws_iam_role_name" {
    type = string
    default = ""
}

variable "aws_iam_policy_name" {
    type = string
    default = ""
}

variable "account_id" {
    type = list(string)
    default = [""]
}