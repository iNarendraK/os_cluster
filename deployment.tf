resource "openshift_project" "openshift-demo" {
  metadata {
    annotations = {
      "openshift.io/description" = "This is just for demo purpose"
      "openshift.io/display-name" = "openshift-demo-cluster"
    }

    name = var.project_name
  }

  lifecycle {
    ignore_changes = [metadata[0].annotations]
  }
}

root@minikube:/home/ubuntu/narendra# ^C
root@minikube:/home/ubuntu/narendra# vi resources.tf
root@minikube:/home/ubuntu/narendra# cat resources.tf
resource "openshift_deployment_config" "openshiftapp" {
  metadata {
    name = var.deployment_name
    labels = {
      test = "nginx"
    }
  }

  spec {
    replicas = 3
    selector = {
        test = "nginx"
    }


    template {
      metadata {
        labels = {
          test = "nginx"
        }
      }

      spec {
        container {
          image = "nginx:1.7.8"
          name  = "example"

          resources {
            limits {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests {
              cpu    = "250m"
              memory = "50Mi"
            }
          }

          liveness_probe {
            http_get {
              path = "/nginx_status"
              port = 80

              http_header {
                name  = "X-Custom-Header"
                value = "Awesome"
              }
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }

    trigger {
      type = "ConfigChange"
    }
  }
}
