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
    }
  },
]
