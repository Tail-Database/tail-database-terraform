resource "aws_s3_bucket" "terraform_state" {
  bucket = "tail-database-terraform-state"
}

resource "aws_s3_bucket" "tails_r2_bucket" {
  for_each = { for environment in var.environments : environment => environment }

  bucket = "tail-database-tails-${each.value}"
}
