terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "docker_image_pull_failure" {
  source    = "./modules/docker_image_pull_failure"

  providers = {
    shoreline = shoreline
  }
}