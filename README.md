# docker-glbd
Dockerized [Galera Load Balancer](https://github.com/codership/glb) daemon

## Help

The `ENTRYPOINT` is `glbd` it self, so this will print the help:

```sh
docker run --rm -it pierredavidbelanger/glbd:1.0.1.1 --version --help
```
```sh
Usage:
  /usr/local/sbin/glbd [OPTIONS] LISTEN_ADDRESS [DESTINATION_LIST]
...
```

## Usage

I will not repeat their doc, but here instead, is an example to

- listen on `8080` on the host
- round robin requests to `app1:8181` and `app2:8181` (ip are resolved on startup)
- with a pool of `4` threads
- and expose the control interface on `4444` on the host

```sh
docker run --rm -it \
    -p '8080:8080' \
    -p '4444:4444' \
    pierredavidbelanger/glbd:1.0.1.1 \
        --round \
        --threads 4 \
        --control 0.0.0.0:4444 \
        0.0.0.0:8080 \
        app1:8181 \
        app2:8181
```
