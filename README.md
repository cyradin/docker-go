# Docker-golang

Docker image for development with VS Code

## Usage

Add to your `docker-compose.yml`:

```yaml
services:
    go:
      image: cyradin/go:latest
      volumes:
        - "./:/home/user/app"
```

To specify UID and GID, according to [this instruction](https://dev.to/acro5piano/specifying-user-and-group-in-docker-i2e), add to docker-compose.yml:
```yaml
services:
    go:
      user: "${UID}:${GID}"
      // ...
```

And run containers with:
```shell
$ UID=${UID} GID=${GID} docker-compose up
```