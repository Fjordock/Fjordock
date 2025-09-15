#!/bin/bash

# Test script for local testing of Fjordock Alpine images
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}=== Fjordock Alpine Image Testing ===${NC}"

# Change to the project root
cd $FJORDOCK

echo -e "${GREEN}1. Workflow testing with act...${NC}"
# Run act without event file (workflow_dispatch has no inputs)
act workflow_dispatch \
    --container-daemon-socket unix:///var/run/docker.sock \
    -W .github/workflows/build-alpine.yml \
    --artifact-server-path /tmp/act-artifacts \
    --container-options '--privileged' \
    --bind \
    --rebuild

# Build all three architectures using buildx
echo -e "${GREEN}2. Building multiarch Alpine images...${NC}"

docker buildx build --platform linux/amd64 -t fjordock/alpine:3.22.1-amd64 --load -f docker/alpine/Dockerfile .
docker buildx build --platform linux/arm64 -t fjordock/alpine:3.22.1-arm64 --load -f docker/alpine/Dockerfile .

# Test package versions and functionality
echo -e "${GREEN}3. Testing package versions and functionality...${NC}"

test_architecture() {
    local arch=$1
    local tag=$2
    echo -e "${YELLOW}Testing $arch...${NC}"
    
    # Test basic functionality
    echo "→ Architecture: $arch"
    docker run --rm --platform linux/$arch fjordock/alpine:$tag /bin/sh -c "echo '$arch build' && uname -m && templater --help"
    echo -e "${GREEN}✅ $arch tests passed!${NC}"
}

# Test all architectures
test_architecture "amd64" "3.22.1-amd64"
test_architecture "arm64" "3.22.1-arm64"

echo -e "${GREEN}✅ All tests passed successfully!${NC}"
echo -e "${YELLOW}Images available:${NC}"
docker images | grep fjordock/alpine