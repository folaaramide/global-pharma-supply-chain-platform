resource "aws_cloudwatch_dashboard" "pharma" {

  dashboard_name = "pharma-dashboard"

  dashboard_body = jsonencode({

    widgets = [

      {

        type = "metric"

        x = 0

        y = 0

        width = 12

        height = 6

        properties = {

          metrics = [

            [

              "AWS/EC2",

              "CPUUtilization",

              "InstanceId",

              aws_instance.app.id

            ]

          ]

          period = 300

          stat = "Average"

          region = "eu-west-2"

          title = "EC2 CPU"

        }

      }

    ]

  })

}