resource "consul_config_entry" "proxy_defaults" {
  kind = "proxy-defaults"
  name = "global"

  config_json = jsonencode({
    Config = {
      envoy_statsd_url = "udp://172.17.0.1:9125",
      envoy_extra_static_clusters_json = file("${path.module}/envoy-cluster.json")
      envoy_tracing_json = file("${path.module}/envoy-tracing.json")
    }
  })
}

