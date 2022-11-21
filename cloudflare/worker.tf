resource "cloudflare_worker_script" "get_tail_script" {
  for_each = { for environment in var.environments : environment => environment }

  name    = "get-tail"
  content = file("${path.module}/scripts/dist/get-tail.js")

  r2_bucket_binding {
    name        = "R2_BUCKET"
    bucket_name = "tail-database-tails-${each.value}"
  }

  kv_namespace_binding {
    name         = "CACHE"
    namespace_id = cloudflare_workers_kv_namespace.namespace[each.value].id
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

resource "cloudflare_worker_route" "get_tail_route" {
  for_each = { for environment in var.environments : environment => environment }

  depends_on = [cloudflare_worker_script.get_tail_script]

  zone_id     = cloudflare_zone.taildatabase.id
  script_name = "get-tail"
  pattern     = "${each.value}-api.${var.zone}/tail/*"
}

resource "cloudflare_worker_script" "search_index_script" {
  for_each = { for environment in var.environments : environment => environment }

  name    = "search-index"
  content = file("${path.module}/scripts/dist/search-index.js")

  r2_bucket_binding {
    name        = "R2_BUCKET"
    bucket_name = "tail-database-tails-${each.value}"
  }

  kv_namespace_binding {
    name         = "CACHE"
    namespace_id = cloudflare_workers_kv_namespace.namespace[each.value].id
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

resource "cloudflare_worker_route" "search_index_route" {
  for_each = { for environment in var.environments : environment => environment }

  depends_on = [cloudflare_worker_script.search_index_script]

  zone_id     = cloudflare_zone.taildatabase.id
  script_name = "search-index"
  pattern     = "${each.value}-api.${var.zone}/search-index"
}

resource "cloudflare_worker_script" "get_tails_script" {
  for_each = { for environment in var.environments : environment => environment }

  name    = "get-tails"
  content = file("${path.module}/scripts/dist/get-tails.js")

  r2_bucket_binding {
    name        = "R2_BUCKET"
    bucket_name = "tail-database-tails-${each.value}"
  }

  kv_namespace_binding {
    name         = "CACHE"
    namespace_id = cloudflare_workers_kv_namespace.namespace[each.value].id
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

resource "cloudflare_worker_route" "get_tails_route" {
  for_each = { for environment in var.environments : environment => environment }

  depends_on = [cloudflare_worker_script.get_tails_script]

  zone_id     = cloudflare_zone.taildatabase.id
  script_name = "get-tails"
  pattern     = "${each.value}-api.${var.zone}/tails"
}
