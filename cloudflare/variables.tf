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

variable "kv_namespace_name" {
  description = "Workers KV Namespace name"
  type        = string
}

variable "add_tail_endpoint" {
  description = "Endpoint to be called for adding a TAIL to Tail Database"
  type        = string
}

variable "auth_endpoint" {
  description = "Endpoint to be called to authenticate with Tail Database"
  type        = string
}

variable "reveal_endpoint" {
  description = "Endpoint to be called to get reveal and eve coin id"
  type        = string
}
