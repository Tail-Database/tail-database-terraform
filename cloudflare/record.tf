# THIS IS FOR THE LEGACY TAILDATABASE SITE - WILL BE REMOVED SOONtm
resource "cloudflare_record" "legacy_api" {
  zone_id = cloudflare_zone.taildatabase.id
  name    = "api"
  value   = "taildatabase-api-prod-alb-1780330969.us-west-2.elb.amazonaws.com"
  type    = "CNAME"
  ttl     = 1 # auto
  proxied = true
}

# THIS IS FOR THE LEGACY TAILDATABASE SITE - WILL BE REMOVED SOONtm
resource "cloudflare_record" "legacy_images_dev" {
  zone_id = cloudflare_zone.taildatabase.id
  name    = "images-dev"
  value   = "images-dev.taildatabase.com.s3.us-west-2.amazonaws.com"
  type    = "CNAME"
  ttl     = 1 # auto
  proxied = true
}

# THIS IS FOR THE LEGACY TAILDATABASE SITE - WILL BE REMOVED SOONtm
resource "cloudflare_record" "legacy_images" {
  zone_id = cloudflare_zone.taildatabase.id
  name    = "images"
  value   = "images.taildatabase.com.s3.us-west-2.amazonaws.com"
  type    = "CNAME"
  ttl     = 1 # auto
  proxied = true
}

# THIS IS FOR THE LEGACY TAILDATABASE SITE - WILL BE REMOVED SOONtm
resource "cloudflare_record" "root" {
  zone_id = cloudflare_zone.taildatabase.id
  name    = "taildatabase.com"
  value   = "www.taildatabase.com.s3-website-us-west-2.amazonaws.com"
  type    = "CNAME"
  ttl     = 1 # auto
  proxied = false
}

# THIS IS FOR THE LEGACY TAILDATABASE SITE - WILL BE REMOVED SOONtm
resource "cloudflare_record" "test" {
  zone_id = cloudflare_zone.taildatabase.id
  name    = "test"
  value   = "test.taildatabase.com.s3-website-us-west-2.amazonaws.com"
  type    = "CNAME"
  ttl     = 1 # auto
  proxied = true
}

# THIS IS FOR THE LEGACY TAILDATABASE SITE - WILL BE REMOVED SOONtm
resource "cloudflare_record" "www" {
  zone_id = cloudflare_zone.taildatabase.id
  name    = "www"
  value   = "d1ad9hbazknvo4.cloudfront.net"
  type    = "CNAME"
  ttl     = 1 # auto
  proxied = false
}




# Domain ownership verification for fcoleman on Keybase
resource "cloudflare_record" "freddie_keybase" {
  zone_id = cloudflare_zone.taildatabase.id
  name    = "taildatabase.com"
  value   = "keybase-site-verification=ZBMapxr3C0ASpJTQ4N7ynMzS7BiIeKNQ-emDm3jZMmo"
  type    = "TXT"
  ttl     = 1 # auto
}
