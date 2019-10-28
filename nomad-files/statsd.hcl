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
    network {}

    service {
      name = "statsd"
      port = 9102
      connect {
        sidecar_service {}
      }
    }

    task "server" {
      driver = "docker"

      resources {
        cpu    = 50
        memory = 50
      }

      config {
        image = "prom/statsd-exporter"
        network_mode = "host"
        args = [
          "--statsd.listen-udp", "172.17.0.1:9125",
          "--statsd.listen-tcp", "",
          "--web.listen-address", "127.0.0.1:9102"]
      }
    }
  }
}
