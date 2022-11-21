terraform {
  backend "s3" {
    bucket                      = "tail-database-terraform-state"
    key                         = "state.tfstate"
    region                      = "us-east-1"
    encrypt                     = true
    skip_credentials_validation = true
  }
}
