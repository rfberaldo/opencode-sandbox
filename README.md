# opencode-sandbox

This uses [podman](https://docs.podman.io) to mount a directory into a sandbox to use [opencode](https:/opencode.ai).

## Install

```bash
ln -s "$PWD/opencode-sandbox" ~/.local/bin/opencode-sandbox
```

It needs any ubuntu-based image with opencode installed, build `Dockerfile` on this repo for sample:

```bash
podman build -t localhost/opencode-ubuntu:latest -f Dockerfile .
```

## Usage

Syntax: `opencode-sandbox <image> <dir>`

```bash
# e.g. mount current directory into ubuntu sandbox:
opencode-sandbox localhost/opencode-ubuntu:latest .
```
