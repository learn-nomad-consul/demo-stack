job "statsd" {
  datacenters = ["dc1"]
  type = "system"

  constraint {
    attribute = "${meta.instance_group}"
    value     = "monitoring"
    operator  = "!="
  }

  group "statsd" {
    network {
      mode = "host"
      port "web" {}
    }

    service {
      name = "statsd"
      port = "web"
    }

    task "server" {
      driver = "docker"

      resources {
        cpu    = 50
        memory = 100
      }

      config {
        image = "prom/statsd-exporter:v0.12.2"
        args = [
          "--statsd.listen-udp", "172.17.0.1:9125",
          "--statsd.listen-tcp", "",
          "--web.listen-address", "0.0.0.0:${NOMAD_HOST_PORT_web}"]
        network_mode = "host"
      }
    }
  }
}
