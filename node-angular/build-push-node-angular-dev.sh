#!/bin/bash
# build-push-node-angular-dev.sh
# Usage:
#   ./build-push-node-angular-dev.sh [node_version] [angular_version]
# Example:
#   ./build-push-node-angular-dev.sh 24 21

set -euo pipefail
cd "$(dirname "$0")"

NODE_VERSION="${1:-22}"
ANGULAR_VERSION="${2:-20}"
IMAGE="ghcr.io/hallboard-team/node-angular:${NODE_VERSION}-${ANGULAR_VERSION}"

echo "🏗️  Building dev image: $IMAGE"

docker build \
  -t "$IMAGE" \
  --build-arg NODE_VERSION="$NODE_VERSION" \
  --build-arg ANGULAR_VERSION="$ANGULAR_VERSION" \
  -f Dockerfile.dev .

echo "📤 Pushing $IMAGE to GHCR..."
docker push "$IMAGE"

echo "✅ Done."
