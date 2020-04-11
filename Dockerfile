FROM alpine

COPY ./copy-pasta.plugin.zsh /src/

WORKDIR src
ENTRYPOINT bash
