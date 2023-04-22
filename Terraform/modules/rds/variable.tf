variable "AWS_REGION" {
    type        = string
    default     = "ap-southeast-1"
}

variable "BACKUP_RETENTION_PERIOD" {
    default = "7"
}

variable "PUBLICLY_ACCESSIBLE" {
    default = "true"
}

variable "ELEARNING_RDS_USERNAME" {
    default = "anhgrew"
}

variable "ELEARNING_RDS_PASSWORD" {
    default = "anhgrew123"
}

variable "ELEARNING_RDS_ALLOCATED_STORAGE" {
    type = string
    default = "20"
}

variable "ELEARNING_RDS_ENGINE" {
    type = string
    default = "mariadb"
}

variable "ELEARNING_RDS_ENGINE_VERSION" {
    type = string
    default = "10.6.10"
}

variable "DB_INSTANCE_CLASS" {
    type = string
    default = "db.t2.micro"
}

variable "ELEARNING_RDS_NAME" {
    type = string
    default = "db"
}

variable "ELEARNING_RDS_IDENTIFIER" {
    type = string
    default = "elearning"
}

variable "ELEARNING_RDS_DB_NAME" {
    type = string
    default = "elearning"
}


variable "RDS_CIDR" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "0.0.0.0/0"
}

variable "ENVIRONMENT" {
  description = "AWS VPC Environment Name"
  type        = string
  default     = "Development"
}

variable "vpc_private_subnet1" {
  description = "AWS VPC Environment Name"
  type        = string
  default     = ""
}

variable "vpc_private_subnet2" {
  description = "AWS VPC Environment Name"
  type        = string
  default     = ""
}

variable "vpc_private_subnet3" {
  description = "AWS VPC Environment Name"
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "AWS VPC Environment Name"
  type        = string
  default     = ""
}
