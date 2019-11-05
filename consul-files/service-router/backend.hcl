kind = "service-router"
name = "backend"

routes = [
  {
    match {
      http {
        path_prefix = "/v2"
      }
    }
    destination {
      service = "echo2"
    }
  },
  {
    match {
      http {
        path_prefix = "/"
      }
    }
    destination {
      service = "echo1"
      num_retries = 3
      retry_on_status_codes = [500, 501]
      request_timeout = "200ms"
      retry_on_connect_failure = true
    }
  },
]
