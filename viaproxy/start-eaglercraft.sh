#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

# ViaProxy (TCP 25568) must already be bound first; this script starts it then websockify.
JAVA="${JAVA_HOME:-/usr/lib/jvm/java-21-openjdk-amd64}/bin/java"
[ -x "$JAVA" ] || JAVA="$(command -v java)"

echo "Starting ViaProxy..."
"$JAVA" -jar ViaProxy.jar cli &
VP_PID=$!
sleep 8

echo "Starting websockify (WebSocket -> TCP 25568) on :8080..."
websockify 0.0.0.0:8080 127.0.0.1:25568 &
WS_PID=$!

echo "ViaProxy PID: $VP_PID"
echo "websockify PID: $WS_PID"
echo "Connect Eaglercraft to ws://<host>:8080 (or wss:// via reverse proxy)."
wait