locals {
  env = lower(terraform.workspace)

  filenames = concat(var.filenames, ["${var.content_folder}.png"])
}