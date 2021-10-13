#!/bin/sh

ssh-add ~/.ssh/vkral/orakral

echo ""
echo "# Tunnel with nomad ui on localhost"
echo "ssh -J opc@jump.vkr.al -L 4646:stack-node-1.private:4646 -L 8500:stack-node-1.private:8500 -L 8600:stack-node-1.private:8600 opc@stack-node-1.private"

echo ""
echo "# Launch nomad dev cluster"
echo "nomad agent -dev -bind 0.0.0.0"

echo "# Launch consul dev cluster"
echo "consul agent -dev -bind 172.16.1.11 -client 172.16.1.11"
