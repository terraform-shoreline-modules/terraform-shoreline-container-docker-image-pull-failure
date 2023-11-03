resource "shoreline_notebook" "docker_image_pull_failure" {
  name       = "docker_image_pull_failure"
  data       = file("${path.module}/data/docker_image_pull_failure.json")
  depends_on = [shoreline_action.invoke_check_docker_registry_connectivity,shoreline_action.invoke_docker_pull]
}

resource "shoreline_file" "check_docker_registry_connectivity" {
  name             = "check_docker_registry_connectivity"
  input_file       = "${path.module}/data/check_docker_registry_connectivity.sh"
  md5              = filemd5("${path.module}/data/check_docker_registry_connectivity.sh")
  description      = "Check the network connectivity between the Docker engine and the container registry to ensure that there are no network issues."
  destination_path = "/tmp/check_docker_registry_connectivity.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_file" "docker_pull" {
  name             = "docker_pull"
  input_file       = "${path.module}/data/docker_pull.sh"
  md5              = filemd5("${path.module}/data/docker_pull.sh")
  description      = "Verify that the container registry credentials are correct and that the Docker engine has the necessary privileges to access the images stored in the registry."
  destination_path = "/tmp/docker_pull.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_check_docker_registry_connectivity" {
  name        = "invoke_check_docker_registry_connectivity"
  description = "Check the network connectivity between the Docker engine and the container registry to ensure that there are no network issues."
  command     = "`chmod +x /tmp/check_docker_registry_connectivity.sh && /tmp/check_docker_registry_connectivity.sh`"
  params      = ["DOCKER_REGISTRY_HOSTNAME_OR_IP_ADDRESS","DOCKER_REGISTRY_PORT_NUMBER"]
  file_deps   = ["check_docker_registry_connectivity"]
  enabled     = true
  depends_on  = [shoreline_file.check_docker_registry_connectivity]
}

resource "shoreline_action" "invoke_docker_pull" {
  name        = "invoke_docker_pull"
  description = "Verify that the container registry credentials are correct and that the Docker engine has the necessary privileges to access the images stored in the registry."
  command     = "`chmod +x /tmp/docker_pull.sh && /tmp/docker_pull.sh`"
  params      = ["DOCKER_REGISTRY_URL","DOCKER_REGISTRY_PASSWORD","IMAGE_NAME","DOCKER_REGISTRY_USERNAME"]
  file_deps   = ["docker_pull"]
  enabled     = true
  depends_on  = [shoreline_file.docker_pull]
}

