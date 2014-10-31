### Notes

The docker image is based on
[Planitar Base Image](https://github.com/PlanitarInc/docker-image-base),
which is basically a
[Ubuntu 14.04 Image](https://registry.hub.docker.com/_/ubuntu/)
with some preinstalled packages (`curl`, `gawk` and several more).
If your project requires a different base image, just fork and change.

Additionally, FTB's original
[count-von-count](https://github.com/FTBpro/count-von-count)
assumes openresty is installed to `/usr/local/openresty`.
This docker image installs `openresty` to `/opt/openresty`, so...
feel free to fork and change.

### Build

```sh
git clone https://github.com/PlanitarInc/docker-image-count-von-count
cd docker-image-count-von-count
git submodule update --init --recursive
make build
```

### Run

Expose nginx's 80 port:
```sh
docker run -d --name cvc -p 80:80 planitar/count-von-count
```

Alternatively, expose nginx and redis:
```sh
docker run -d --name cvc -p 80:80 -p 6379:6379 planitar/count-von-count
```
