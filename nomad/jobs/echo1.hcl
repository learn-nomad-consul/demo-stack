job "echo1" {
  datacenters = ["dc1"]

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
        sidecar_task {
          resources {
            cpu    = 100
            memory = 50
          }
        }
      }
    }

    task "echo1" {
      driver = "docker"
      resources {
        cpu    = 100
        memory = 50
      }

      config {
        image = "hashicorp/http-echo:0.2.3"
        args = ["--text", "\"==> echo 1\""]
      }
    }
  }
}
