FROM quay.io/yeebase/debian-base:stretch

ENV TIDEWAYS_PORT_UDP 8135
ENV TIDEWAYS_PORT_TCP 9135

RUN clean-install apt-transport-https ca-certificates curl gnupg2 && \
    curl -sL https://s3-eu-west-1.amazonaws.com/qafoo-profiler/packages/EEB5E8F4.gpg | apt-key add - && \
    echo "deb http://s3-eu-west-1.amazonaws.com/qafoo-profiler/packages debian main" > /etc/apt/sources.list.d/tideways.list && \
    clean-install tideways-daemon

COPY entrypoint.sh /

EXPOSE $TIDEWAYS_PORT_UDP/udp
EXPOSE $TIDEWAYS_PORT_TCP

ENTRYPOINT ["/entrypoint.sh", "tideways-daemon"]
