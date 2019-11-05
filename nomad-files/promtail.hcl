job "promtail" {
  datacenters = ["dc1"]
  type = "system"

  constraint {
    attribute = "${meta.instance_group}"
    value     = "monitoring"
    operator  = "!="
  }

  group "promtail" {
    network {
      mode = "host"
      port "web" {
        static = 9080
        to = 9080
      }
    }

    task "promtail" {
      driver = "docker"

      resources {
        cpu    = 50
        memory = 100
      }

      config {
        image = "grafana/promtail:v0.4.0"
        args = [
          "-config.file", "/etc/promtail/config.yml",
        ]
        network_mode = "host"
        volumes = [
          "custom/promtail.yml:/etc/promtail/config.yml",
          "/var/lib/docker/containers/:/var/lib/docker/containers/:ro"
        ]
      }

      template {
        data = <<EOF
server:
  http_listen_port: 9080
  grpc_listen_port: 0

positions:
  filename: /tmp/positions.yaml

client:
  url: http://172.16.2.10:3100/loki/api/v1/push

scrape_configs:
 - job_name: system
   pipeline_stages:
   - docker:
   static_configs:
   - targets:
      - localhost
     labels:
      job: varlogs
      host: {{ env "meta.instance_group" }}
      __path__: /var/lib/docker/containers/*/*.log
EOF
        destination = "custom/promtail.yml"
      }
    }
  }
}
