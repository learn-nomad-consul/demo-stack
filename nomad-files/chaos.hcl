job "chaos" {
  datacenters = ["dc1"]

  constraint {
    attribute = "${meta.instance_group}"
    value     = "dataplane"
  }

  group "chaos" {
    network {
      mode = "bridge"
    }

    service {
      name = "chaos"
      port = 8080

      connect {
        sidecar_service {}
      }
    }

    task "chaos" {
      driver = "docker"
      resources {
        cpu    = 100
        memory = 100
      }

      config {
        image = "err0r500/chaos-container"
      }
    }
  }
}
