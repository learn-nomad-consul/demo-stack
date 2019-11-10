kind = "service-splitter"
name = "echo1"

splits = [
  {
    weight  = 60
  },
  {
    weight  = 40
    service = "chaos"
  },
]
