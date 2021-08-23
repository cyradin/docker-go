# Docker-golang

Docker image for development with VS Code using [Remote Containers extension](https://code.visualstudio.com/docs/remote/containers)

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
      user: "${USER_ID}:${GROUP_ID}"
      // ...
```

And run containers with:
```shell
$ USER_ID=${UID} GROUP_ID=${GID} docker-compose up
```