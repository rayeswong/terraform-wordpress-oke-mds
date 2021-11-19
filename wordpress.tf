# wordpress database setup
data "template_file" "create_wp_db" {
  template = file("${path.module}/scripts/create_wp_db.template.sh")

  vars = {
    admin_username = var.mysql_db_system_admin_username
    admin_password = var.mysql_db_system_admin_password
    mds_ip = oci_mysql_mysql_db_system.MDSinstance.ip_address
    wp_schema = var.wp_schema
    wp_db_username = var.wp_db_username
    wp_db_password = var.wp_db_password
  }
}

resource null_resource "create_wp_db" {
  connection {
    host        = oci_core_instance.operator.public_ip
    private_key = file(var.operator_ssh_private_key_path)
    timeout     = "40m"
    type        = "ssh"
    user        = "opc"

  }

  depends_on = [null_resource.install_mysqlsh]

  provisioner "file" {
    content     = data.template_file.create_wp_db.rendered
    destination = "~/create_wp_db.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x $HOME/create_wp_db.sh",
      "bash $HOME/create_wp_db.sh",
      "rm -f $HOME/create_wp_db.sh"
    ]
  }
}

#wordpress
data "template_file" "install_wp" {
  template = file("${path.module}/scripts/install_wp.template.sh")
  vars = {
    wp_values = "~/wp_values.yaml"
    wp_service_name = var.wp_service_name
    wp_namespace = var.wp_namespace
  }
}

data "template_file" "wp_values" {
  template = file("${path.module}/wordpress/values.template.yaml")
  vars = {
    wp_username = var.wp_admin_username
    wp_password = var.wp_admin_password
    wp_email = var.wp_admin_email
    wp_firstname = var.wp_admin_username
    wp_lastname = var.wp_admin_username
    wp_blogname = "wordpress"
    mds_ip = oci_mysql_mysql_db_system.MDSinstance.ip_address
    mds_username = var.wp_db_username
    mds_password = var.wp_db_password
    wp_schema = var.wp_schema
  }
}

resource null_resource "install_wp" {
  connection {
    host        = oci_core_instance.operator.public_ip
    private_key = file(var.operator_ssh_private_key_path)
    timeout     = "40m"
    type        = "ssh"
    user        = "opc"

  }

  depends_on = [null_resource.create_wp_db, oci_containerengine_node_pool.pool1]

  provisioner "file" {
    content     = data.template_file.install_wp.rendered
    destination = "~/install_wp.sh"
  }

  provisioner "file" {
    content     = data.template_file.wp_values.rendered
    destination = "~/wp_values.yaml"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x $HOME/install_wp.sh",
      "bash $HOME/install_wp.sh",
      "rm -f $HOME/install_wp.sh",
      "rm -f $HOME/wp_values.yaml"
    ]
  }
}