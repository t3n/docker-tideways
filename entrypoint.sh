#!/bin/sh
# ----------------------------------------------------------------------------
# entrypoint for container
# ----------------------------------------------------------------------------
set -e

HOST_IP=`/bin/grep $HOSTNAME /etc/hosts | /usr/bin/cut -f1`
export HOST_IP=${HOST_IP}

echo
echo "container started with ip: ${HOST_IP}..."
echo

env=${TIDEWAYS_ENV:-development}

extra="--hostname=tideways-docker-container"
extra="${extra} --env=${env}"
extra="${extra} --address=0.0.0.0:${TIDEWAYS_PORT_TCP}"
extra="${extra} --udp=0.0.0.0:${TIDEWAYS_PORT_UDP}"

if [ "$1" == "tideways-daemon" ]; then
	echo "starting tideways-daemon, with: ${extra}"
	/usr/bin/tideways-daemon $extra
elif [ "$1" == "bash" ] || [ "$1" == "shell" ]; then
	echo "starting /bin/bash with /etc/profile..."
	/bin/bash --rcfile /etc/profile
else
	echo "Running something else ($@)"
	exec "$@"
fi
