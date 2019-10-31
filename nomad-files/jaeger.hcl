job "jaeger" {
  datacenters = ["dc1"]

  constraint {
    attribute = "${meta.instance_group}"
    value     = "monitoring"
  }

  group "jaeger" {
    network {
      mode = "bridge"
      port "traces" {
        static = 9411
        to = 9411
      }
      port "web" {
        static = 16686
        to = 16686
      }
    }

    task "server" {
      driver = "docker"

      config {
        image = "jaegertracing/all-in-one:1.14"
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
