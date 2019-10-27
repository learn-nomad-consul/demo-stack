job "echo2" {
  datacenters = ["dc1"]
  type = "service"

  group "echo2" {
    network {
      mode = "bridge"
    }

    service {
      name = "echo2"
      port = 5678
      connect {
        sidecar_service {}
      }
    }

    task "server" {
      driver = "docker"
      config {
        image = "hashicorp/http-echo"
        args = ["--text", "\"==> echo 2\""]
      }
    }
  }
}
