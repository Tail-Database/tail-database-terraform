resource "cloudflare_worker_script" "get_tail_script" {
  for_each   = { for environment in var.environments : environment => environment }

  name    = "get-tail"
  content = file("${path.module}/scripts/dist/get-tail.js")

  r2_bucket_binding {
    name        = "R2_BUCKET"
    bucket_name = "tail-database-tails-${each.value}"
  }

  secret_text_binding {
    name = "R2_ACCESS_KEY"
    text = var.r2_access_key
  }

  secret_text_binding {
    name = "R2_SECRET_KEY"
    text = var.r2_secret_key
  }
}

resource "cloudflare_worker_script" "search_index_script" {
  for_each   = { for environment in var.environments : environment => environment }

  name    = "search-index"
  content = file("${path.module}/scripts/dist/search-index.js")

  r2_bucket_binding {
    name        = "R2_BUCKET"
    bucket_name = "tail-database-tails-${each.value}"
  }

  secret_text_binding {
    name = "R2_ACCESS_KEY"
    text = var.r2_access_key
  }

  secret_text_binding {
    name = "R2_SECRET_KEY"
    text = var.r2_secret_key
  }
}
