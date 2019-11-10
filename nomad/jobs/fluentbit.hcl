job "fluentbit" {
  datacenters = ["dc1"]
  type = "system"

  constraint {
    attribute = "${meta.instance_group}"
    value     = "monitoring"
    operator  = "!="
  }

  group "fluentbit" {
    network {
      mode = "host"
    }

    task "fluentbit" {
      driver = "docker"

      resources {
        cpu    = 50
        memory = 100
      }

      config {
        image = "grafana/fluent-bit-plugin-loki"
        network_mode = "host"
        volumes = [
          "custom/fluent-bit.conf:/fluent-bit/etc/fluent-bit.conf"
        ]
      }

      template {
        data = <<EOF
[INPUT]
    Name   forward
    Listen 172.17.0.1
    Port   24224

[Output]
    Name loki
    Match *
    Url http://172.16.2.10:3100/loki/api/v1/push
    BatchWait 1
    BatchSize 1001024
    Labels {group="{{ env "meta.instance_group" }}"}
    LineFormat json
    LogLevel info
EOF
        destination = "custom/fluent-bit.conf"
      }
    }
  }
}
