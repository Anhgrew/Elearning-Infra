resource "null_resource" "db_script" {
  depends_on = [module.elearning-rds] # Wait for the RDS instance to be created before running the local-exec provisioner

  connection {
    host     = module.elearning-rds.rds_prod_endpoint
    user     = module.elearning-rds.rds_prod_user
    password = var.PASSWORD
    port     = module.elearning-rds.rds_prod_port
    # Add any additional connection parameters if needed, such as SSL options
  }

  provisioner "local-exec" {
    command = <<-EOT
      mysql -h "${module.elearning-rds.rds_prod_endpoint}" \
            -u "${module.elearning-rds.rds_prod_user}" \
            -p"${var.PASSWORD}" \
            -P "${module.elearning-rds.rds_prod_port}" \
            -e 'CREATE DATABASE IF NOT EXISTS elearning;' \
            && mysql -h "${module.elearning-rds.rds_prod_endpoint}" \
               -u "${module.elearning-rds.rds_prod_user}" \
               -p"${var.PASSWORD}" \
               -P "${module.elearning-rds.rds_prod_port}" \
               elearning < "${path.module}/db_backup.sql"
    EOT
  }
}
