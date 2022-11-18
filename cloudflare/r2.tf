resource "aws_s3_bucket" "tails_r2_bucket" {
  for_each = { for environment in var.environments : environment => environment }

  bucket = "tail-database-tails-${each.value}"
}

resource "aws_s3_bucket" "ui_r2_bucket" {
  for_each = { for environment in var.environments : environment => environment }

  bucket = "tail-database-ui-${each.value}"
}
