variable "cloudflare_account_id" {
  description = "Cloudflare Account ID"
  type        = string
}

variable "r2_access_key" {
  description = "Cloudflare R2 access key with edit permission"
  type        = string
}

variable "r2_secret_key" {
  description = "Cloudflare R2 secret key"
  type        = string
}

variable "environments" {
  description = "Supported environments e.g. testnet and mainnet"
  type        = list(string)
}

variable "zone" {
  description = "Root domain name"
  type        = string
}
