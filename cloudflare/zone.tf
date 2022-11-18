resource "cloudflare_zone" "taildatabase" {
  account_id = var.cloudflare_account_id
  zone       = "taildatabase.com"
}
