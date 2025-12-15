#!/usr/bin/env bash
set -euo pipefail

# -------- CONFIG --------
IMAGE_NAME=$(basename "$PWD")
REGISTRY_HOST="homelab:5000"
# ------------------------

# Get commit SHA (short)
COMMIT_SHA=$(git rev-parse --short HEAD)

echo "🔨 Building image..."
podman build \
  -t ${IMAGE_NAME}:latest \
  -t ${IMAGE_NAME}:${COMMIT_SHA} \
  .

echo "🧩 Tagging images for registry..."
podman tag ${IMAGE_NAME}:latest ${REGISTRY_HOST}/${IMAGE_NAME}:latest
podman tag ${IMAGE_NAME}:${COMMIT_SHA} ${REGISTRY_HOST}/${IMAGE_NAME}:${COMMIT_SHA}

echo "📤 Pushing images..."
podman push ${REGISTRY_HOST}/${IMAGE_NAME}:latest
podman push ${REGISTRY_HOST}/${IMAGE_NAME}:${COMMIT_SHA}

echo "✅ Done! Images pushed:"
echo "   - ${REGISTRY_HOST}/${IMAGE_NAME}:latest"
echo "   - ${REGISTRY_HOST}/${IMAGE_NAME}:${COMMIT_SHA}"

echo "♻ Refreshing container..."
cd ../homelab
podman pull ${REGISTRY_HOST}/${IMAGE_NAME}:latest
systemctl --user daemon-reload
systemctl --user restart bingo.service

