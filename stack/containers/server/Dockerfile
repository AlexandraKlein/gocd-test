ARG GOCD_VERSION

FROM gocd/gocd-server:${GOCD_VERSION}

ARG GOCD_USER
ARG GOCD_PASSWORD_ENCRYPTED

# Copy plugins
COPY ./plugins/ /godata/plugins/external/

# Copy cruise config
COPY ./config/cruise-config.xml /godata/config/cruise-config.xml

# Copy Slack config
COPY ./config/go_notify.conf /home/go/go_notify.conf

RUN echo "${GOCD_USER}=${GOCD_PASSWORD_ENCRYPTED}" > /etc/go-users

# Create SSH config
RUN mkdir /home/go/.ssh && \
    ssh-keyscan github.com > /home/go/.ssh/known_hosts

COPY ./keys/id_rsa /home/go/.ssh/id_rsa
COPY ./keys/id_rsa.pub /home/go/.ssh/id_rsa.pub

RUN chown -R go:go /home/go/.ssh/ && \
    chmod -R 400 /home/go/.ssh/id_rsa && \
    chmod -R 400 /home/go/.ssh/id_rsa.pub

RUN chown -R 1000 /godata/plugins/external
RUN chown -R 1000 /godata/config
RUN chown -R 1000 /etc/go-users
RUN chown -R 1000 /home/go/go_notify.conf
