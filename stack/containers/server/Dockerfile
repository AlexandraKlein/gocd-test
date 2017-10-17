ARG GOCD_VERSION

FROM gocd/gocd-server:${GOCD_VERSION}

COPY ./plugins/ /godata/plugins/external/
RUN chown -R 1000 /godata/plugins/external

RUN mkdir /home/go/.ssh && \
    ssh-keyscan github.com > /home/go/.ssh/known_hosts

COPY ./keys/id_rsa /home/go/.ssh/id_rsa
COPY ./keys/id_rsa.pub /home/go/.ssh/id_rsa.pub

RUN chown -R go:go /home/go/.ssh/ && \
    chmod -R 400 /home/go/.ssh/id_rsa && \
    chmod -R 400 /home/go/.ssh/id_rsa.pub

COPY ./config/cruise-config.xml /godata/config/cruise-config.xml

RUN chown -R go:go /godata/config
