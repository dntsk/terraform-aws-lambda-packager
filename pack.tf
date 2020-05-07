resource "null_resource" "tmp" {
  provisioner "local-exec" {
    command = "mkdir -p ${var.tmp_dir}/${var.name}"
  }

  triggers = {
    the_trigger = timestamp()
  }
}

resource "null_resource" "copy" {
  provisioner "local-exec" {
    command = "cp -fr ${var.source_dir}/* ${var.tmp_dir}/${var.name}/"
  }

  depends_on = [null_resource.tmp]

  triggers = {
    the_trigger = timestamp()
  }
}

resource "null_resource" "pip" {
  provisioner "local-exec" {
    command = "pip3 install -r ${var.source_dir}/requirements.txt -t ${var.tmp_dir}/${var.name}"
  }

  depends_on = [null_resource.copy]

  triggers = {
    the_trigger = timestamp()
  }
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${var.tmp_dir}/${var.name}"
  output_path = "/tmp/${var.name}.zip"

  depends_on = [null_resource.pip]
}
