resource "aws_launch_template" "pharma" {

  name_prefix = "pharma-"

  image_id = data.aws_ami.amazon_linux.id

  instance_type = "t3.micro"

  vpc_security_group_ids = [

    aws_security_group.ec2.id

  ]

  iam_instance_profile {

    name = aws_iam_instance_profile.ec2.name

  }

  user_data = base64encode(

    file("${path.module}/user_data.sh")

  )

}

resource "aws_autoscaling_group" "pharma" {

  desired_capacity = 2

  max_size = 3

  min_size = 2

  health_check_type = "ELB"

  health_check_grace_period = 300

  vpc_zone_identifier = [

    aws_subnet.private_app_a.id,

    aws_subnet.private_app_b.id

  ]

  target_group_arns = [

    aws_lb_target_group.main.arn

  ]

  launch_template {

    id = aws_launch_template.pharma.id

    version = "$Latest"

  }

  tag {

    key = "Name"

    value = "pharma-asg"

    propagate_at_launch = true

  }

}