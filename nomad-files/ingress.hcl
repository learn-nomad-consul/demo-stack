job "ingress" {
  datacenters = ["dc1"]

  constraint {
    attribute = "${meta.instance_group}"
    value     = "ingress"
  }

  group "ingress" {
    network {
      mode = "bridge"
      port "http" {
        static = 9090
        to = 9090
      }
    }

    service {
      name = "ingress"

      connect {
        sidecar_service {
          proxy {
            upstreams {
              destination_name = "backend"
              local_bind_port = 12345
            }
          }
        }
      }
    }

    task "ingress" {
      driver = "docker"

      config {
        image = "nicholasjackson/fake-service:v0.7.8"
      }

      env {
        NAME = "ingress"
        LISTEN_ADDR = "0.0.0.0:${NOMAD_PORT_http}"
        UPSTREAM_URIS = "http://127.0.0.1:12345/"
        TRACING_ZIPKIN = "http://172.16.2.10:9411"
        UPSTREAM_CALL = "true"
        MESSAGE = "Hello World"
        HTTP_CLIENT_KEEP_ALIVES = "false"
        TIMING_50_PERCENTILE = "30ms"
        TIMING_90_PERCENTILE = "60ms"
        TIMING_99_PERCENTILE = "90ms"
        TIMING_VARIANCE = 10
      }
    }
  }
}
