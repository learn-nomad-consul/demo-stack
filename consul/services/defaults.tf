resource "consul_config_entry" "backend" {
  name = "backend"
  kind = "service-defaults"

  config_json = jsonencode({
    Protocol    = "http"
  })
}

resource "consul_config_entry" "ingress" {
  name = "ingress"
  kind = "service-defaults"

  config_json = jsonencode({
    Protocol    = "http"
  })
}

resource "consul_config_entry" "echo1" {
  name = "echo1"
  kind = "service-defaults"

  config_json = jsonencode({
    Protocol    = "http"
  })
}

resource "consul_config_entry" "echo2" {
  name = "echo2"
  kind = "service-defaults"

  config_json = jsonencode({
    Protocol    = "http"
  })
}

resource "consul_config_entry" "chaos" {
  name = "chaos"
  kind = "service-defaults"

  config_json = jsonencode({
    Protocol    = "http"
  })
}

resource "consul_config_entry" "statsd" {
  name = "statsd"
  kind = "service-defaults"

  config_json = jsonencode({
    Protocol    = "http"
  })
}

resource "consul_config_entry" "jaeger-zipkin" {
  name = "jaeger-zipkin"
  kind = "service-defaults"

  config_json = jsonencode({
    Protocol    = "http"
  })
}

resource "consul_config_entry" "loki" {
  name = "loki"
  kind = "service-defaults"

  config_json = jsonencode({
    Protocol    = "http"
  })
}
