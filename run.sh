#!/bin/bash

if [ -z ${RTCWKILL_ADDRESS+x} ]; then
    echo "No RTCWKILL_ADDRESS defined"
    exit 1
fi
if [ -z ${RCONPASSWORD+x} ]; then
    echo "No RCONPASSWORD defined"
    exit 1
fi

RTCWKILL_FREQUENCY=${RTCWKILL_FREQUENCY:-"0 4 * * *"}

logger() {
    echo "[$(date)] " "$@"
}

logger "Starting main loop."
while [ 1 ]; do
    hypnos "${RTCWKILL_FREQUENCY}"
    logger "Waiting for server to empty if it is not already."

    PLAYERCOUNT=1
    until [ "${PLAYERCOUNT}" == "0" ]; do
        sleep 30
        XML=$(quakestat -xml -rws "${RTCWKILL_ADDRESS}")
        PLAYERCOUNT=$(echo "${XML}" | xmlstarlet sel -t -v "/qstat/server/numplayers")
    done

    logger "Running quit over rcon."
    timeout 5 icecon "${RTCWKILL_ADDRESS}" "${RCONPASSWORD}" -c "quit"
done
