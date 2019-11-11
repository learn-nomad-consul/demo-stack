provider "consul" {
  address    = "localhost:8500"
  datacenter = "dc1"
  version = "~> 2.6"
}

module "proxy-defaults" {
  source = "./proxy-defaults"
}

module "services" {
  source = "./services"
}
