kind = "proxy-defaults"
name = "global"

config {
  envoy_statsd_url = "udp://172.18.0.2:9125"

  envoy_extra_static_clusters_json = <<EOL
    {
      "name": "zipkin",
      "type": "STRICT_DNS",
      "connect_timeout": "3.000s",
      "lb_policy": "ROUND_ROBIN",
      "load_assignment": {
          "cluster_name": "zipkin",
          "endpoints": [
              {
                  "lb_endpoints": [
                      {
                          "endpoint": {
                              "address": {
                                  "socket_address": {
                                      "address": "172.16.2.10",
                                      "port_value": 9411,
                                      "protocol": "TCP"
                                  }
                              }
                          }
                      }
                  ]
              }
          ]
      }
    }
  EOL

  envoy_tracing_json = <<EOL
    {
        "http": {
            "name": "envoy.zipkin",
            "config": {
                "collector_cluster": "zipkin",
                "collector_endpoint": "/api/v1/spans"
            }
        }
    }
  EOL
}
