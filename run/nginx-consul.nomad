job "nginx" {
  datacenters = ["dc1"]
  type = "service"
  group "nginx" {
    count = 2
    task "nginx" {
      driver = "docker"
      config {
        image = "nginx"
        port_map {
          http = 8080
        }
        port_map {
          https = 443
        }
        volumes = [
          "custom/default.conf:/etc/nginx/conf.d/default.conf"
        ]
      }
      template {
        data = <<EOH
          server {
            listen 8080;
            server_name nginx.service.consul;
            location /nginx {
              root /local/data;
            }
          }
        EOH
        destination = "custom/default.conf"
      }
     template {
        data = <<EOH
        <H1>Hello, I am nginx. and I run on Nomad</H1>
        {{ if keyExists "features/demo" }}
        <H2>Dynamic is the word! {{ key "features/demo" }}</H2>
        {{ else }}
        <H2>I am hardcoded. No Consul buddy hanging around ...</H2>
        {{ end }}
        <br />
        Node Environment Information:  <br />
        node_id:     {{ env "node.unique.id" }} <br/>
        datacenter:  {{ env "NOMAD_DC" }}
        EOH
        destination = "local/data/nginx/index.html"
      }
      resources {
        cpu    = 100 # 100 MHz
        memory = 128 # 128 MB
        network {
          mbits = 10
          port "http" {
              static = 8080
          }
          port "https" {
              static= 443
          }
        }
      }
      service {
        name = "nginx"
        tags = [ "nginx", "web", "urlprefix-/nginx" ]
        port = "http"
        check {
          type     = "tcp"
          interval = "10s"
          timeout  = "2s"
        }
      }
    }
  }
}
