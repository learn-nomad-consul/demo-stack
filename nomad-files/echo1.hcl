job "echo1" {
  datacenters = ["dc1"]
  type = "service"

  constraint {
    attribute = "${meta.instance_group}"
    value     = "dataplane"
  }

  group "echo1" {
    network {
      mode = "bridge"
    }

    service {
      name = "echo1"
      port = 5678
      connect {
        sidecar_service {}
      }
    }

    task "server" {
      driver = "docker"
      config {
        image = "hashicorp/http-echo"
        args = ["--text", "\"==> echo 1\""]
      }
    }
  }
}
