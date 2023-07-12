module "alarm" {
  source                    = "clouddrove/cloudwatch-alarms/aws"
  version                   = "1.3.0"
  name                      = "alarm"
  environment               = "test"
  label_order               = ["name", "environment"]
  alarm_name                = "cpu-alarm"
  comparison_operator       = "GreaterThanUpperThreshold"
  evaluation_periods        = 2
  threshold_metric_id       = "e1"
  query_expressions         = [{
    id          = "e1"
    expression  = "ANOMALY_DETECTION_BAND(m1)"
    label       = "CPUUtilization (Expected)"
    return_data = "true"
  }]
  query_metrics             = [{
    id          = "m1"
    return_data = "true"
    metric_name = "CPUUtilization"
    namespace   = "AWS/EC2"
    period      = "120"
    stat        = "Average"
    unit        = "Count"
    dimensions  = {
      InstanceId = ""           //describe the instance id
    }
  },
  {
    id          = "m2"
    return_data = "true"
    metric_name = "CPUUtilization"
    namespace   = "AWS/EC2"
    period      = "120"
    stat        = "Average"
    unit        = "Count"
    dimensions  = {
      InstanceId = ""                  // describe the instance id
    }
  }]
  alarm_description         = "This metric monitors EC2 CPU utilization"
  alarm_actions             = []
  actions_enabled           = true
  insufficient_data_actions = []
  ok_actions                = []
}
