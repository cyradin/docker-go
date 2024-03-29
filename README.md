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

### Run as non-privileged user

#### Method 1:

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

#### Method 2:
Just add user and group ids (run `id -u` and `id -g` to get them) to `docker-compose.override.yml`:
```yaml
services:
  go:
    user: "1000:1000"
```

### Preserve go packages (i.e. VSCode Go extension's analysis tools)

Add volumes to docker-compose.yml

```yaml
services:
    go:
      image: cyradin/go:latest
      volumes:
        - "./:/home/user/app"
        - "go-pkg:/home/user/go/pkg"
        - "go-bin:/home/user/go/bin"

volumes:
  go-pkg:
    driver: local
  go-bin:
    driver: local
```
