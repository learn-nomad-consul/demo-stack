job "ingress" {
  datacenters = ["dc1"]
  type = "service"

  group "ingress" {
    network {
      mode = "bridge"
      port "http" {
        static = 8080
        to = 80
      }
    }

    service {
      name = "ingress"
      port = 80

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

    task "server" {
      driver = "docker"
      config {
        image = "nginx:alpine"
        volumes = [
          "custom/default.conf:/etc/nginx/conf.d/default.conf"
        ]
      }

      template {
        data = <<EOH
          server {
            listen 80;
            location / {
              grpc_pass grpc://127.0.0.1:12345;
            }
          }
        EOH
        destination = "custom/default.conf"
      }
    }
  }
}
