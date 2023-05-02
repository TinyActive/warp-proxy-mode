#!/bin/bash

# Start warp-svc in the background and save its process ID.
/usr/local/bin/warp-svc &
warp_svc_pid=$!

# Wait for warp-svc to start up and connect to the Cloudflare network.
sleep 5

# Register, set mode to "proxy", and connect.
sh -c '/bin/echo -e "y\n" |warp-cli --accept-tos register'
warp-cli --accept-tos set-mode proxy
warp-cli --accept-tos set-custom-endpoint 162.159.192.1:2408
warp-cli --accept-tos set-proxy-port 9191
warp-cli --accept-tos connect

socat TCP-LISTEN:8080,bind=0.0.0.0,reuseaddr,fork TCP:127.0.0.1:9191 & sleep 3

# Wait for warp-svc to exit, and check its exit code.
if ! wait $warp_svc_pid; then
  echo "warp-svc exited unexpectedly with code $?."
  exit 1
fi