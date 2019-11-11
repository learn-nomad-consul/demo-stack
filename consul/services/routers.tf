resource "consul_config_entry" "backend_router" {
  name = "backend"
  kind = "service-router"

  config_json = jsonencode({
    Routes = [
      {
        Match = {
          HTTP = {
            PathPrefix = "/v2"
          }
        }
        Destination = {
          Service = "echo2"
        }
      },
      {
        Match = {
          HTTP = {
            PathPrefix = "/"
          }
        }
        Destination = {
          Service = "echo1"
          NumRetries = 3
          RetryOnStatusCodes = [500, 501]
          RequestTimeout = "200ms"
          RetryOnConnectFailure = true
        }
      },
    ]
  })

  depends_on = [
    consul_config_entry.echo1,
    consul_config_entry.echo2,
  ]
}
