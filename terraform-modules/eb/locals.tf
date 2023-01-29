locals {
  env  = lower(terraform.workspace)
  name = "${var.project}-eb-${local.env}"
}
