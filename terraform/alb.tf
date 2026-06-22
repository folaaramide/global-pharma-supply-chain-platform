resource "aws_lb" "main" {

  name = "${var.project_name}-alb"

  internal = false

  load_balancer_type = "application"

  security_groups = [aws_security_group.alb.id]

  subnets = [

    aws_subnet.public_a.id,

    aws_subnet.public_b.id

  ]

  tags = {

    Name = "${var.project_name}-alb"

  }

}

resource "aws_lb_target_group" "main" {

  name = "pharma-target-group"

  port = 5000

  protocol = "HTTP"

  vpc_id = aws_vpc.main.id

  health_check {

    path = "/"

    port = "5000"

    protocol = "HTTP"

  }

}

resource "aws_lb_listener" "main" {

  load_balancer_arn = aws_lb.main.arn

  port = 80

  protocol = "HTTP"

  default_action {

    type = "forward"

    target_group_arn = aws_lb_target_group.main.arn

  }

}