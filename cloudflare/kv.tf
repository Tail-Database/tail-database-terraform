resource "cloudflare_workers_kv_namespace" "namespace" {
  for_each = { for environment in var.environments : environment => environment }

  title = "${var.kv_namespace_name}-${each.value}"
}
