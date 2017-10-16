ARG GOCD_VERSION

FROM gocd/gocd-server:${GOCD_VERSION}

COPY ./plugins/ /godata/plugins/external/
RUN chown -R 1000 /godata/plugins/external
