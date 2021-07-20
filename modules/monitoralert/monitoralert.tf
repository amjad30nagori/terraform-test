resource "azurerm_monitor_metric_alert" "alert" {
  name                = var.alert_name
  resource_group_name = var.resource_group
  scopes              = var.vm_id
  description         = "Action will be triggered when CPU usage goes beyond 70%."
  enabled             = true

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Percentage CPU"
    operator         = "GreaterThan"
    threshold        = 70
    aggregation      = "Average"
    period           = "PT5M"

    email_action {
      send_to_service_owners = true

      custom_emails = [
        var.email,
      ]
    }
      properties = {
      severity        = "incredible"
      acceptance_test = "true"
    }
  }
}