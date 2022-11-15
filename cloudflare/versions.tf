terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.39.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "3.27.0"
    }
  }
}

provider "aws" {
  access_key                  = var.r2_access_key
  secret_key                  = var.r2_secret_key
  region                      = "auto"
  skip_credentials_validation = true
  skip_region_validation      = true
  skip_requesting_account_id  = true
  endpoints {
    s3 = "https://${var.cloudflare_account_id}.r2.cloudflarestorage.com"
  }
}

// CLOUDFLARE_API_TOKEN env var must be set
provider "cloudflare" {
  account_id = var.cloudflare_account_id
}
