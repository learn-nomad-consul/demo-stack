job "prometheus" {
  datacenters = ["dc1"]

  constraint {
    attribute = "${meta.instance_group}"
    value     = "monitoring"
  }

  group "prometheus" {
    network {
      mode = bridge
      port "http" {
        static = 9090
        to = 9090
      }
    }

    service {
      name = "prometheus"
      port = 9090

      connect {
        sidecar_service {
          proxy {
            upstreams {
              destination_name = "statsd"
              local_bind_port = 12345
            }
          }
        }
      }
    }

    task "server" {
      driver = "docker"

      resources {
        cpu    = 100
        memory = 100
      }

      config {
        image = "prom/prometheus"
        args = [
          "--web.listen-address", "0.0.0.0:9090", # fixme
          "--config.file", "/etc/prometheus/prometheus.yml"
        ]
        volumes = [
          "custom/prometheus.yml:/etc/prometheus/prometheus.yml"
        ]
      }
      template {
        data = <<EOF
global:
  scrape_interval:     15s
  evaluation_interval: 15s
  external_labels:
      monitor: 'prometheus-stack-monitor'

scrape_configs:
  - job_name: 'containers'
    scrape_interval: 10s
    scrape_timeout: 5s
    consul_sd_configs:
      - server: '172.17.0.1:8500'
    relabel_configs:
      - source_labels: [__meta_consul_service]
        target_label: service
        regex: statsd
        action: keep
      - source_labels: [__address__]
        target_label:  '__address__'
        replacement:   'localhost:12345'
      - source_labels: [__meta_consul_node]
        target_label:  'node'
      - source_labels: [__meta_consul_address]
        target_label:  'node_ip'
        EOF
        destination = "custom/prometheus.yml"
      }
    }

    #TODO : add grafana here

  }
}


