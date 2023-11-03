bash

#!/bin/bash



# Setting variables

DOCKER_REGISTRY=${DOCKER_REGISTRY_HOSTNAME_OR_IP_ADDRESS}

DOCKER_REGISTRY_PORT=${DOCKER_REGISTRY_PORT_NUMBER}



# Ping the Docker registry to check network connectivity

ping -c 3 $DOCKER_REGISTRY



if [[ $? -ne 0 ]]; then

  echo "Error: Unable to connect to the Docker registry at $DOCKER_REGISTRY:$DOCKER_REGISTRY_PORT"

  exit 1

fi



echo "Success: Network connectivity between Docker engine and registry is established."

exit 0