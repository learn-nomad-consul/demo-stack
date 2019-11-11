job "jaeger" {
  datacenters = ["dc1"]

  constraint {
    attribute = "${meta.instance_group}"
    value     = "monitoring"
  }

  group "jaeger" {
    network {
      mode = "host"
    }

    service {
      name = "jaeger-zipkin"
      port = 9411
    }

    task "server" {
      driver = "docker"

      config {
        image = "jaegertracing/all-in-one:1.14.0"
        network_mode = "host"
      }

      resources {
        cpu    = 100
        memory = 100
      }

      env {
        COLLECTOR_ZIPKIN_HTTP_PORT = 9411
      }
    }
  }
}
