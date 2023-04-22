resource "null_resource" "init_db" {
  depends_on = [module.elearning-rds] # Wait for the RDS instance to be created before running the local-exec provisioner

  connection {
    host     = module.elearning-rds.rds_prod_endpoint
    user     = module.elearning-rds.rds_prod_user
    password = var.PASSWORD
    port     = module.elearning-rds.rds_prod_port
  }

  provisioner "local-exec" {
    command = "mysql -h ${module.elearning-rds.rds_prod_endpoint} -u ${module.elearning-rds.rds_prod_user} -p'${var.PASSWORD}' -P ${module.elearning-rds.rds_prod_port} -e 'CREATE DATABASE IF NOT EXISTS elearning;' < db_backup.sql"

  }
}
