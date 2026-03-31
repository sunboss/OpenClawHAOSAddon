#!/usr/bin/env bash
set -euo pipefail

TAG="${1:-2026.03.31.1}"
TARGET_HOST="${2:-192.168.1.66}"
TARGET_USER="${3:-root}"
TARGET_PATH="${4:-/tmp}"

IMAGE_NAME="openclawhaosaddon:${TAG}"
REMOTE_IMAGE="docker.io/sunboss/openclawhaosaddon:${TAG}"
ARCHIVE="openclawhaosaddon-${TAG}.tar"

echo "1. 构建本地镜像 (${IMAGE_NAME})"
docker build -t "${IMAGE_NAME}" ./openclaw_assistant

echo "2. 导出镜像为 tar"
docker save "${IMAGE_NAME}" -o "${ARCHIVE}"

echo "3. 拷贝到 HAOS 主机 (${TARGET_HOST})"
scp "${ARCHIVE}" "${TARGET_USER}@${TARGET_HOST}:${TARGET_PATH}/"

echo "4. 在 HAOS 载入并打 tag"
ssh "${TARGET_USER}@${TARGET_HOST}" bash -c "'
  docker load -i ${TARGET_PATH}/${ARCHIVE}
  docker tag ${IMAGE_NAME} ${REMOTE_IMAGE}
'"

echo "完成：镜像 ${REMOTE_IMAGE} 已在 HAOS 上准备好，直接安装即可。"
