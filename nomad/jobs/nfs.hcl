job "nfs" {
  datacenters = ["dc1"]

  constraint {
    attribute = "${meta.instance_group}"
    value     = "nfs"
  }

  group "nfs" {
    network {
      mode = "host"
    }

    task "nfs" {
      driver = "docker"

      resources {
        cpu    = 100
        memory = 100
      }

      config {
        image = "erichough/nfs-server:latest"
        args = [
          "--cap-add",  "SYS_ADMIN"
        ]
        privileged = true
        network_mode = "host"
        volumes = [
          "nfs/exports:/etc/exports:rw",
          "/data/grafana:/mnt/grafana"
        ]
      }

      template {
        data = <<EOF
/mnt/grafana/ 172.16.2.10/32(rw)
EOF

        destination = "nfs/exports"
      }
    }
  }
}

