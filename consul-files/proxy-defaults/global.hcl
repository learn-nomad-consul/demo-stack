kind = "proxy-defaults"
name = "global"

config {
  envoy_statsd_url = "udp://172.17.0.1:9125"
  envoy_extra_static_clusters_json = <<EOL
    {
      "connect_timeout": "3.000s",
      "dns_lookup_family": "V4_ONLY",
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
      },
      "name": "zipkin",
      "type": "STRICT_DNS"
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
