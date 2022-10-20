resource "aws_grafana_workspace" "grafanaworkspace" {
  name                     = var.name
  account_access_type      = var.account_access_type
  authentication_providers = var.authentication_providers
  permission_type          = var.permission_type
  role_arn                 = aws_iam_role.AMGPrometheusDataSource-role.arn
  #name                     = var.grafana_workspacename
  tags    = {
    Name = var.name
  }
}


resource "aws_grafana_workspace_api_key" "key" {
  key_name        = "admin"
  key_role        = var.Admin_permission
  seconds_to_live = 3600
  workspace_id    = aws_grafana_workspace.grafanaworkspace.id
}

/*resource "aws_grafana_workspace_saml_configuration" "grafanaspce" {
  editor_role_values = ["admin"]
  idp_metadata_url   = var.idp_url
  workspace_id       = aws_grafana_workspace.grafanaworkspace.id
  role_assertion     = var.role_assertion
  admin_role_values  = var.admin_role_values 
}*/



resource "aws_iam_role" "AMGPrometheusDataSource-role" {
  name = var.aws_iam_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "grafana.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy" "AMGPrometheusDataSource-policy" {
  name        = var.aws_iam_policy_name
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "VisualEditor0",
        Action = "sts:AssumeRole",
        Effect   = "Allow",
        Resource = [
          "arn:aws:iam::${var.account_id[0]}:role/AMGPrometheusDataSourceRole-Development",
          "arn:aws:iam::${var.account_id[0]}:role/AMGCloudWatchDataSourceRole-Development",
          "arn:aws:iam::${var.account_id[1]}:role/AMGCloudWatchDataSourceRole-Distinct",
        ]
      },
    ]
  })
}

##Policy attachment######

resource "aws_iam_policy_attachment" "AMGPrometheusDataSource-policyattachment" {
  name = "demo"
  roles      = [aws_iam_role.AMGPrometheusDataSource-role.name]
  policy_arn = aws_iam_policy.AMGPrometheusDataSource-policy.arn
}

output "namespace" {
  value = aws_grafana_workspace.grafanaworkspace.name
}