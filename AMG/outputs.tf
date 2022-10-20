output "workspace_arn" {
    description = "The Amazon Resource Name (ARN) of the Grafana Workspce"
    value = aws_grafana_workspace.grafanaworkspace.arn
}

output "workspace_endpoint" {
    description = "The Endpoint of the Grafana Workspce"
    value = aws_grafana_workspace.grafanaworkspace.endpoint
}