
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Docker Image Pull Failure.
---

A Docker Image Pull Failure is an incident where the Docker engine fails to download a specific image from a container registry. This issue can occur due to various reasons such as network connectivity issues, authentication problems, or server-side errors. As a result of this failure, the container that requires the specific image fails to start or run, causing a disruption in the application or service that relies on that container.

### Parameters
```shell
export REGISTRY_URL="PLACEHOLDER"

export IMAGE_NAME="PLACEHOLDER"

export DOCKER_REGISTRY_HOSTNAME_OR_IP_ADDRESS="PLACEHOLDER"

export DOCKER_REGISTRY_PORT_NUMBER="PLACEHOLDER"

export DOCKER_REGISTRY_PASSWORD="PLACEHOLDER"

export DOCKER_REGISTRY_USERNAME="PLACEHOLDER"

export DOCKER_REGISTRY_URL="PLACEHOLDER"
```

## Debug

### Check Docker network connectivity
```shell
docker run --rm alpine ping ${REGISTRY_URL}
```

### Check Docker daemon status
```shell
systemctl status docker
```

### Check Docker version
```shell
docker version
```

### View Docker image details
```shell
docker image inspect ${IMAGE_NAME}
```

### View Docker logs
```shell
journalctl -u docker.service
```

### Check Docker image tags
```shell
curl -s https://${REGISTRY_URL}/v2/${IMAGE_NAME}/tags/list
```

### Test Docker image pull
```shell
docker pull ${IMAGE_NAME}
```

### Authenticate Docker registry login
```shell
docker login ${REGISTRY_URL}
```

### Check Docker credentials
```shell
cat ~/.docker/config.json
```

## Repair

### Check the network connectivity between the Docker engine and the container registry to ensure that there are no network issues.
```shell
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


```

### Verify that the container registry credentials are correct and that the Docker engine has the necessary privileges to access the images stored in the registry.
```shell


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


```