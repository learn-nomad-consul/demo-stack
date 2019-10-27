job "echo" {
  datacenters = ["dc1"]
  type = "service"

  group "echo" {
    network {
      mode = "bridge"
    }

    service {
      name = "echo"
      port = 80
      connect {
        sidecar_service {}
      }
    }

    task "server" {
      driver = "docker"
      config {
        image = "kennethreitz/httpbin"
      }
    }
  }
}
