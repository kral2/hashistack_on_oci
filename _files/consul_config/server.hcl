# Consul config file

server = true
bootstrap_expect = 3
bind_addr = "{{ GetPrivateInterfaces | include \"network\" \"172.16.1.0/24\" | attr \"address\" }}"
client_addr = "{{ GetPrivateInterfaces | include \"network\" \"172.16.1.0/24\" | attr \"address\" }}"
ui_config = {
  enabled = true
}
