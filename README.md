# Tail Database Terraform

This repo contains Terraform for provisioning the infrastructure behind [taildatabase.com](https://www.taildatabase.com/).

## Cloudflare

Cloudflare is used to provide global object storage and caching without being tied to a single cloud provider.

### R2

R2 buckets are created for each environment (e.g. testnet/mainnet). The buckets store all asset token data that is displayed on the website. There are also buckets for storing the UI code.

### Workers

Cloudflare workers access data in R2 buckets allowing the site to operate like a static website without needing a full node or a database. This completely removes multiple attack vectors and reduces the cost of running the site to $0/month. For comparison, running a full node + DB in AWS can easily cost > $200/month as a base cost before any traffic is taken into account.

The worker scripts are created in TypeScript so compilation is required before Terraform can deploy the scripts to Cloudflare.
