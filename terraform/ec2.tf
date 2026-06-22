data "aws_ami" "amazon_linux" {

  most_recent = true

  owners = ["amazon"]

  filter {

    name = "name"

    values = ["al2023-ami-2023.*-x86_64"]

  }

}

resource "aws_instance" "app" {

  ami = data.aws_ami.amazon_linux.id

  instance_type = "t3.micro"

  subnet_id = aws_subnet.private_app_a.id

  vpc_security_group_ids = [

    aws_security_group.ec2.id

  ]

  iam_instance_profile = aws_iam_instance_profile.ec2.name

  associate_public_ip_address = false

  user_data = file("${path.module}/user_data.sh")

  tags = {

    Name = "${var.project_name}-ec2"

  }

}