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
