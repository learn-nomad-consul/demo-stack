job "statsd" {
  datacenters = ["dc1"]
  type = "system"

# everywhere except on monitoring otherwise prometheus get killed
  constraint {
    attribute = "${meta.instance_group}"
    value     = "monitoring"
    operator  = "!="
  }

  group "statsd" {
    network {
      mode = "host"
      port "http" {
        static = 9102
      }
    }

    service {
      name = "statsd"
      port = 9102
    }

    task "server" {
      driver = "docker"

      resources {
        cpu    = 50
        memory = 100
      }

      config {
        image = "prom/statsd-exporter"
        args = [
          "--statsd.listen-udp", "172.17.0.1:9125",
          "--statsd.listen-tcp", "",
          "--web.listen-address", "0.0.0.0:9102"]
        network_mode = "host"
      }
    }
  }
}
