ARG GOCD_VERSION
ARG GOCD_AGENT_CONTAINER

FROM gocd/gocd-agent-${GOCD_AGENT_CONTAINER}:${GOCD_VERSION}

RUN mkdir /home/go/.ssh && \
    ssh-keyscan github.com > /home/go/.ssh/known_hosts

COPY ./keys/id_rsa /home/go/.ssh/id_rsa
COPY ./keys/id_rsa.pub /home/go/.ssh/id_rsa.pub

RUN chown -R go:go /home/go/.ssh/ && \
    chmod -R 400 /home/go/.ssh/id_rsa && \
    chmod -R 400 /home/go/.ssh/id_rsa.pub
