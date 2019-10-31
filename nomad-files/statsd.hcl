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
      mode = "bridge"
      port "web" {
        static = 9102
        to = 9102
      }
    }

    service {
      name = "statsd"
      port = "9102"
      connect {
        sidecar_service {}
      }
    }

    task "server" {
      driver = "docker"

      resources {
        cpu    = 50
        memory = 100
      }

      config {
        image = "prom/statsd-exporter"
        ipv4_address = "172.18.0.2"
        args = [
          "--statsd.listen-udp", "172.18.0.2:9125",
          "--statsd.listen-tcp", "",
          "--web.listen-address", "127.0.0.1:9102"]
        network_mode = "monitoring-net"
      }
    }
  }
}
