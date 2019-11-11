resource "consul_config_entry" "echo1_splitter"{
  kind = "service-splitter"
  name = "echo1"

  config_json = jsonencode({
    splits = [
      {
        weight  = 60
      },
      {
        weight  = 40
        service = "chaos"
      },
    ]
  })

  depends_on = [
    consul_config_entry.echo1,
    consul_config_entry.chaos,
  ]
}
