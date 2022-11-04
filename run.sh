docker build -t test-nginx .
docker run --name my-nginx -p 8080:80 --rm test-nginx
