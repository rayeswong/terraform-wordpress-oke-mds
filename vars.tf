#identity
variable compartment_ocid { }
variable tenancy_ocid { }
variable region { }

#network


#oke
variable kube_cluster_name { default = "oke_cluster" }
variable kube_version { default = "v1.20.11" }
variable node_shape { default = "VM.Standard.E4.Flex" }
variable node_shape_ocpus { default = 1 }
variable node_shape_memory { default = 8 }
variable node_pool_ssh_public_key { default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCvRZ6JUfI6qGFL5Y3Ql2/9Awr3stdOTUTK2dDbvppG0f8gSACQHK6qdJkuQMESRdaTlxhBAxBxBB46C6d9v2bYSroyNhGPf3Nk2vqaV5Sg75krHqnT4UTnRaTxGj3xj6xtpBsVFABIAK7fNwrrWvza+8MLyX83rwUGlm8CPoI5a32+EUuNEiOzWnPRCtuh+rnpozyRgEQyVD/r0Y/rQIwQVrvdTn2XziIkJ8gxGn39FtswUArwuo/iJ306WXaMxYzTpVVhiw+dzKPOoCz4R0D9PsuxL3EtZeXSi8B8di2Og5caURu4E5j3lsBvUkD/mUD3JTZap9KGImVjfM7B3/zn"}

#operator
variable operator_shape { default = "VM.Standard.E4.Flex" }
variable operator_shape_ocpus { default = 1 }
variable operator_shape_memory { default = 8 }
variable operator_ssh_public_key { default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCvRZ6JUfI6qGFL5Y3Ql2/9Awr3stdOTUTK2dDbvppG0f8gSACQHK6qdJkuQMESRdaTlxhBAxBxBB46C6d9v2bYSroyNhGPf3Nk2vqaV5Sg75krHqnT4UTnRaTxGj3xj6xtpBsVFABIAK7fNwrrWvza+8MLyX83rwUGlm8CPoI5a32+EUuNEiOzWnPRCtuh+rnpozyRgEQyVD/r0Y/rQIwQVrvdTn2XziIkJ8gxGn39FtswUArwuo/iJ306WXaMxYzTpVVhiw+dzKPOoCz4R0D9PsuxL3EtZeXSi8B8di2Og5caURu4E5j3lsBvUkD/mUD3JTZap9KGImVjfM7B3/zn"}
variable operator_ssh_private_key_path { default = "./keys/id_rsa"}
variable operator_os { default = "Oracle Linux" }
variable operator_os_version { default = "7.9" }

# MySQL Data Service
variable "mds_instance_name" {
  description = "Name of the MDS instance"
  default     = "MySQLInstance"
}

variable "mysql_db_system_admin_username" {
  description = "MySQL Database Service Username"
  default     = "admin"
}

variable "mysql_db_system_admin_password" {
  description = "Password for the admin user for MySQL Database Service"
  type        = string
  default     = "Oracle#123"
}

variable "mysql_shape_name" {
    default = "MySQL.VM.Standard.E3.1.8GB"
}

variable "mysql_data_storage_in_gb" {
    default = 50
}

variable "deploy_mds_ha" {
  description = "Deploy High Availability for MDS"
  type        = bool
  default     = false
}

#Wordpress
variable "wp_db_username" {
  description = "WordPress Database User Name."
  type        = string
  default     = "wordpress"
}

variable "wp_db_password" {
  description = "WordPress Database User Password."
  type        = string
  default     = "Oracle#123"
}

variable "wp_schema" {
  description = "WordPress MySQL Schema"
  type        = string
  default     = "wordpress"
}

variable "wp_admin_username" {
  description = "Username of the MDS admin account"
  type        = string
  default     = "admin"
}

variable "wp_admin_password" {
  description = "Password for the admin user for MDS"
  type        = string
  default     = "Oracle#123"
}

variable "wp_admin_email" {
  description = "Email address for the admin user for MDS"
  type        = string
  default     = "admin@example.com"
}

variable "wp_namespace" {
  description = "Kubernetes namespace for WordPress"
  type        = string
  default     = "wordpress-oke"
}

variable "wp_service_name" {
  description = "Name of Kubernetes Service for WordPress"
  type        = string
  default     = "wordpress-oke"
}