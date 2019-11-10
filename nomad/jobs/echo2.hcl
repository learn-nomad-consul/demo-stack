job "echo2" {
  datacenters = ["dc1"]

  constraint {
    attribute = "${meta.instance_group}"
    value     = "dataplane"
  }

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

    task "echo2" {
      driver = "docker"
      resources {
        cpu    = 100
        memory = 100
      }

      config {
        image = "hashicorp/http-echo:0.2.3"
        args = ["--text", "\"==> echo 2\""]
      }
    }
  }
}
