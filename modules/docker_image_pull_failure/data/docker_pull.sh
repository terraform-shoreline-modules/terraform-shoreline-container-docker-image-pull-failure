

#!/bin/bash



# Set the required parameters

DOCKER_REGISTRY=${DOCKER_REGISTRY_URL}

DOCKER_USERNAME=${DOCKER_REGISTRY_USERNAME}

DOCKER_PASSWORD=${DOCKER_REGISTRY_PASSWORD}



# Validate the Docker registry credentials

docker login -u "$DOCKER_USERNAME" -p "$DOCKER_PASSWORD" "$DOCKER_REGISTRY"



# Check the Docker engine privileges

docker pull ${IMAGE_NAME}



# Verify if the image has been successfully pulled

if [ $? -eq 0 ]; then

  echo "Image pulled successfully from Docker registry."

else

  echo "Error: Failed to pull the image from Docker registry."

fi