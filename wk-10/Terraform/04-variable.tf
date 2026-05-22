variable "project_id" {
  description = "GCP project id (student supplies)"
  type        = string
  default     = "jdollas-seir75"
}

variable "region_a" {
  type    = string
  default = "us-central1"
}

variable "region_b" {
  type    = string
  default = "asia-northeast1"
}

variable "student_name" {
  type    = string
  default = "Jdollas"
}

variable "iowa-mig" {
  type    = string
  default = "iowa-mig"
}

variable "lb-ip" {
  type    = string
  default = "http"
}

variable "butt" {
  type    = string
  default = "backend"
}

variable "urll" {
  type    = string
  default = "url_map"
}

variable "foxy" {
  type    = string
  default = "proxy"
}

variable "lb-ip" {
  type    = string
  default = "ip"
}

variable "pf" {
  type    = string
  default = "http_proxy"
}

variable "certy" {
  type    = string
  default = "cert"
}

variable "domain_name" {
  type    = string
  default = "dollas-over-dates.net"
}

variable "hpss" {
  type    = string
  default = "https-proxy"
}

variable "fr443" {
  type    = string
  default = "https"
}

variable "https_map" {
  type    = string
  default = "https_map"
}

variable "http-re" {
  type    = string
  default = "http_redirect"
}

variable "http-forward" {
  type    = string
  default = "http"
}

variable "httptarget" {
  type    = string
  default = "http_proxy"
}
