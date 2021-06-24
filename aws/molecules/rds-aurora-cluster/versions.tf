terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.45"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 2.2"
    }
  }
  required_version = ">= 0.13"
}
