resource "aws_backup_vault" "pharma" {

  name = "pharma-backup-vault"

}

resource "aws_backup_plan" "pharma" {

  name = "pharma-backup-plan"

  rule {

    rule_name = "daily-backup"

    target_vault_name = aws_backup_vault.pharma.name

    schedule = "cron(0 3 * * ? *)"

    lifecycle {

      delete_after = 30

    }

  }

}

resource "aws_iam_role" "backup" {

  name = "pharma-backup-role"

  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Effect = "Allow"

        Principal = {

          Service = "backup.amazonaws.com"

        }

        Action = "sts:AssumeRole"

      }

    ]

  })

}

resource "aws_iam_role_policy_attachment" "backup" {

  role = aws_iam_role.backup.name

  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"

}

resource "aws_backup_selection" "rds" {

  iam_role_arn = aws_iam_role.backup.arn

  name = "pharma-rds-selection"

  plan_id = aws_backup_plan.pharma.id

  resources = [

    aws_db_instance.main.arn

  ]

}