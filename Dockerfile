FROM quay.io/yeebase/debian-base:stretch

ENV TIDEWAYS_VERSION=1.5.74

RUN clean-install apt-transport-https ca-certificates curl gnupg2 && \
    curl -sL https://s3-eu-west-1.amazonaws.com/qafoo-profiler/packages/EEB5E8F4.gpg | apt-key add - && \
    echo "deb http://s3-eu-west-1.amazonaws.com/qafoo-profiler/packages debian main" > /etc/apt/sources.list.d/tideways.list && \
    clean-install tideways-daemon=${TIDEWAYS_VERSION}

EXPOSE 9135
EXPOSE 8135/udp

CMD ["tideways-daemon", "--address=0.0.0.0:9135", "--udp=0.0.0.0:8135", "--hostname=dev"]
