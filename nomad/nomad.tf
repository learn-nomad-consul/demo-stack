provider "nomad" {
  address = "http://localhost:4646"
  version = "~> 1.4"
}

resource "nomad_job" "statsd" {
  jobspec = file("${path.module}/jobs/statsd.hcl")
}

resource "nomad_job" "ingress" {
  jobspec = file("${path.module}/jobs/ingress.hcl")
}
resource "nomad_job" "echo1" {
  jobspec = file("${path.module}/jobs/echo1.hcl")
}
resource "nomad_job" "echo2" {
  jobspec = file("${path.module}/jobs/echo2.hcl")
}
resource "nomad_job" "chaos" {
  jobspec = file("${path.module}/jobs/chaos.hcl")
}


resource "nomad_job" "fluentbit" {
  jobspec = file("${path.module}/jobs/fluentbit.hcl")
}
resource "nomad_job" "loki" {
  jobspec = file("${path.module}/jobs/loki.hcl")
}

resource "nomad_job" "prometheus" {
  jobspec = file("${path.module}/jobs/prometheus.hcl")
}
resource "nomad_job" "jaeger" {
  jobspec = file("${path.module}/jobs/jaeger.hcl")
}
