#!/bin/sh

ssh-add ~/.ssh/vkral/orakral

echo ""
echo "# Tunnel with nomad ui on localhost"
echo "ssh -J opc@jump.vkr.al -L 4646:stack-node-1.private:4646 opc@stack-node-1.private"

echo ""
echo "# Launch nomad dev cluster"
echo "nomad agent -dev -bind 0.0.0.0"