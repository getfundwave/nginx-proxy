TAG=${1:-'alpine'}

PLATFORM="linux/amd64"

if [[ "$TAG" == *"-arm"* ]]; then
  PLATFORM="linux/arm64/v8"
fi

docker build --platform=$PLATFORM -t ghcr.io/getfundwave/nginx-proxy:$TAG .
