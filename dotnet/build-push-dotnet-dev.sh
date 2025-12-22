#!/bin/bash
# -----------------------------
# Build & Start Docker Compose for .NET dev environment (shared stack)
# Usage:
#   ./pull-build-start-dev.sh [dotnet_version]
# Examples:
#   ./build-push-dotnet-dev.sh 10.0
#   ./build-push-dotnet-dev.sh 10.0 runtime
# -----------------------------
#!/bin/bash

set -euo pipefail
cd "$(dirname "$0")"

DOTNET_VERSION="${1:-10.0}"
IMAGE_VARIANT="${2:-sdk}"
IMAGE="ghcr.io/hallboard-team/dotnet:${DOTNET_VERSION}-${IMAGE_VARIANT}"

docker build \
  -t "$IMAGE" \
  --build-arg DOTNET_VERSION="$DOTNET_VERSION" \
  --build-arg DOTNET_VARIANT="$IMAGE_VARIANT" \
  -f Dockerfile.dev .

docker push "$IMAGE"
