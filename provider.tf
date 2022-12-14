terraform {
  required_providers {
    openshift = {
      source = "llomgui/openshift"
      version = "1.1.0"
    }
  }
}

provider "openshift" {}


#to configure the provider is by creating/generating a config in a default location (~/.kube/config). 
#That allows you to leave the provider block completely empty.