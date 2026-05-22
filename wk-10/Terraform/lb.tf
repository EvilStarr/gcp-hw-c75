resource "google_compute_health_check" "http" {
  name = "${var.lb-ip}-hc"

  http_health_check {
    request_path = "/"
    port         = 80
  }
}


resource "google_compute_backend_service" "backend" {
  name          = "${var.butt}-backend"
  protocol      = "HTTP"
  timeout_sec   = 10
  health_checks = [google_compute_health_check.http.id]

  backend {
    group = var.iowa-mig
  }
  # security_policy = google_compute_security_policy.waf.id 
  # security_policy = var.enable_waf ? google_compute_security_policy.waf[0].id : null
  # security_policy = module.waf.security_policy_id
}

#URL Map

resource "google_compute_url_map" "url_map" {
  name            = "${var.urll}-urlmap"
  default_service = google_compute_backend_service.backend.id
}

# Target HTTP Proxy

resource "google_compute_target_http_proxy" "proxy" {
  name    = "${var.foxy}-proxy"
  url_map = google_compute_url_map.url_map.id
}

# Global IP

resource "google_compute_global_address" "ip" {
  name = "${var.lb-ip}-ip"
}

#Forwarding Rule

resource "google_compute_global_forwarding_rule" "http_proxy" {
  name       = "${var.pf}-fw"
  target     = google_compute_target_http_proxy.proxy.id
  port_range = "80"
  ip_address = google_compute_global_address.ip.address
}

resource "google_compute_managed_ssl_certificate" "cert" {
  name = "${var.certy}-cert"

  managed {
    domains = [var.domain_name]
  }
}

# HTTPS PRoxy

resource "google_compute_target_https_proxy" "https_proxy" {
  name             = "${var.hpss}-https-proxy"
  url_map          = google_compute_url_map.url_map.id
  ssl_certificates = [google_compute_managed_ssl_certificate.cert.id]
}

# Forwarding Rule (443)

resource "google_compute_global_forwarding_rule" "https" {
  name       = "${var.fr443}-https"
  target     = google_compute_target_https_proxy.https_proxy.id
  port_range = "443"
  ip_address = google_compute_global_address.ip.address
}

# URL map split

resource "google_compute_url_map" "https_map" {
  name            = "${var.https_map}-https-map"
  default_service = google_compute_backend_service.backend.id
}

resource "google_compute_url_map" "http_redirect" {
  name = "${var.http-re}-http-redirect"

  default_url_redirect {
    https_redirect = true
    strip_query    = false
  }
}

# Redirect

resource "google_compute_target_http_proxy" "http_proxy" {
  name    = "${var.httptarget}-http-proxy"
  url_map = google_compute_url_map.http_redirect.id
}

# HTTP forwarding rule

resource "google_compute_global_forwarding_rule" "http" {
  name       = "${var.http-forward}-http"
  target     = google_compute_target_http_proxy.http_proxy.id
  port_range = "80"
  ip_address = google_compute_global_address.ip.address
}


