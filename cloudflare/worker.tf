resource "cloudflare_worker_script" "get_tail_script" {
  for_each = { for environment in var.environments : environment => environment }

  name    = "get-tail-${each.value}"
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
  script_name = "get-tail-${each.value}"
  pattern     = "${each.value}-api.${var.zone}/tail/*"
}

resource "cloudflare_worker_script" "search_index_script" {
  for_each = { for environment in var.environments : environment => environment }

  name    = "search-index-${each.value}"
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
  script_name = "search-index-${each.value}"
  pattern     = "${each.value}-api.${var.zone}/search-index"
}

resource "cloudflare_worker_script" "get_tails_script" {
  for_each = { for environment in var.environments : environment => environment }

  name    = "get-tails-${each.value}"
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
  script_name = "get-tails-${each.value}"
  pattern     = "${each.value}-api.${var.zone}/tails"
}

resource "cloudflare_worker_script" "add_tail_script" {
  for_each = { for environment in var.environments : environment => environment }

  name    = "add-tail-${each.value}"
  content = file("${path.module}/scripts/dist/add-tail.js")

  plain_text_binding {
    name = "ADD_TAIL_ENDPOINT"
    text = var.add_tail_endpoint
  }
}

resource "cloudflare_worker_route" "add_tail_route" {
  for_each = { for environment in var.environments : environment => environment }

  depends_on = [cloudflare_worker_script.add_tail_script]

  zone_id     = cloudflare_zone.taildatabase.id
  script_name = "add-tail-${each.value}"
  pattern     = "${each.value}-api.${var.zone}/tail"
}

resource "cloudflare_worker_script" "auth_script" {
  for_each = { for environment in var.environments : environment => environment }

  name    = "auth-${each.value}"
  content = file("${path.module}/scripts/dist/auth.js")

  plain_text_binding {
    name = "AUTH_ENDPOINT"
    text = var.auth_endpoint
  }
}

resource "cloudflare_worker_route" "auth_route" {
  for_each = { for environment in var.environments : environment => environment }

  depends_on = [cloudflare_worker_script.auth_script]

  zone_id     = cloudflare_zone.taildatabase.id
  script_name = "auth-${each.value}"
  pattern     = "${each.value}-api.${var.zone}/auth/*"
}
