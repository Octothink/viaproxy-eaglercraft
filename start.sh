#!/usr/bin/env bash
set -e

cd /app/viaproxy

# Start ViaProxy (TCP 25568) in the background
java -Xmx256m -jar ViaProxy.jar cli &
VP_PID=$!

# Wait for ViaProxy to bind
sleep 10

# Bridge Render/Koyeb $PORT (WebSocket + HTTP health check) -> ViaProxy TCP 25568
websockify --web /app/web 0.0.0.0:${PORT:-10000} 127.0.0.1:25568 &
WS_PID=$!

wait $VP_PID $WS_PID