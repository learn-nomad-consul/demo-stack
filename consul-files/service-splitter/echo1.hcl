kind = "service-splitter"
name = "echo1"

splits = [
  {
    weight         = 90
  },
  {
    weight         = 10
    service_subset = "chaos"
  },
]
