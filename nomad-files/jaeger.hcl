job "jaeger" {
  datacenters = ["dc1"]
  type = "service"

  constraint {
    attribute = "${meta.instance_group}"
    value     = "monitoring"
  }

  group "jaeger" {
    network {
      mode = "bridge"

      port "web" {
        static = 16686
        to = 16686
      }
    }

    service {
      name = "jaeger"
      port = 9411
    }

    task "server" {
      driver = "docker"
      config {
        image = "jaegertracing/all-in-one:1.14"
      }
    }
  }
}
