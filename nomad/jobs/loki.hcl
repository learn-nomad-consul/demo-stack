job "loki" {
  datacenters = ["dc1"]

  constraint {
    attribute = "${meta.instance_group}"
    value     = "monitoring"
  }

  group "loki" {
    network {
      mode = "host"
      port "web" {
        static = 3100
        to = 3100
      }
    }

    task "loki" {
      driver = "docker"

      config {
        image = "grafana/loki:v0.4.0"
        network_mode = "host"
      }

      resources {
        cpu    = 100
        memory = 100
      }
    }
  }
}
