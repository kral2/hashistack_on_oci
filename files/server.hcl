server {
    enabled = true
    bootstrap_expect = 3
    server_join {
        retry_join = [ "172.16.1.11", "172.16.1.12", "172.16.1.13" ]
        retry_max = 1
        retry_interval = "15s"  }
}