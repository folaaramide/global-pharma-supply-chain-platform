resource "aws_db_subnet_group" "main" {

  name = "${var.project_name}-db-subnet-group"

  subnet_ids = [

    aws_subnet.private_db_a.id,

    aws_subnet.private_db_b.id

  ]

  tags = {

    Name = "${var.project_name}-db-subnet-group"

  }

}

resource "aws_db_instance" "main" {

  identifier = "${var.project_name}-db"

  engine = "mysql"

  engine_version = "8.0"

  instance_class = "db.t3.micro"

  allocated_storage = 20

  db_name = "pharmadb"

  username = "admin"

  password = "Password123!"

  skip_final_snapshot = true

  publicly_accessible = false

  multi_az = false

  db_subnet_group_name = aws_db_subnet_group.main.name

  vpc_security_group_ids = [

    aws_security_group.rds.id

  ]

  tags = {

    Name = "${var.project_name}-rds"

  }

}