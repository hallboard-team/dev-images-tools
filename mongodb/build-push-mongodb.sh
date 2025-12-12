#!/bin/bash
# -----------------------------
# Build & push the MongoDB image (server + tooling) to the container registry.
# Usage:
#   ./build-push-mongodb.sh [mongo_version] [mongo_tools_version] [image_tag]
# Examples:
#   ./build-push-mongodb.sh               # uses defaults: mongo 7.0, tag mongo-7.0
#   ./build-push-mongodb.sh 7.2           # builds mongo 7.2, tag mongo-7.2
#   ./build-push-mongodb.sh 7.2 7.0 beta  # explicit tools version + tag (mongo-tools 7.0, tag beta)
# -----------------------------
set -euo pipefail
cd "$(dirname "$0")"

MONGO_VERSION="${1:-7.0}"
MONGO_TOOLS_VERSION="${2:-$MONGO_VERSION}"
IMAGE_TAG="${3:-mongo-${MONGO_VERSION}}"

IMAGE_REPO="${IMAGE_REPO:-ghcr.io/hallboard-team/tools}"
IMAGE_REF="${IMAGE_REPO}:${IMAGE_TAG}"

docker build \
  -t "$IMAGE_REF" \
  --build-arg MONGO_VERSION="$MONGO_VERSION" \
  --build-arg MONGO_TOOLS_VERSION="$MONGO_TOOLS_VERSION" \
  -f Dockerfile.dev .

docker push "$IMAGE_REF"
