
resource oci_containerengine_cluster oke-cluster {
  compartment_id = var.compartment_ocid
  kubernetes_version = var.kube_version
  name               = var.kube_cluster_name
  vcn_id = oci_core_vcn.oke-vcn.id
  options {
    add_ons {
      is_kubernetes_dashboard_enabled = "true"
      is_tiller_enabled               = "true"
    }
    admission_controller_options {
      is_pod_security_policy_enabled = "false"
    }
    kubernetes_network_config {
      pods_cidr     = "10.244.0.0/16"
      services_cidr = "10.96.0.0/16"
    }
    service_lb_subnet_ids = [
      oci_core_subnet.oke-svclbsubnet-regional.id,
    ]
  }
  
}

resource oci_containerengine_node_pool pool1 {
  cluster_id     = oci_containerengine_cluster.oke-cluster.id
  compartment_id = var.compartment_ocid
  kubernetes_version = var.kube_version
  name               = "pool1"
  node_shape = var.node_shape

  node_config_details {
    placement_configs {
      availability_domain = data.oci_identity_availability_domain.AD-1.name
      subnet_id           = oci_core_subnet.oke-subnet-regional.id
    }
    size = "2"
  }

  node_shape_config {
        memory_in_gbs = var.node_shape_memory
        ocpus = var.node_shape_ocpus
  }
  
  node_source_details {
    
    image_id    = element([for source in data.oci_containerengine_node_pool_option.pool1_option.sources : source.image_id if length(regexall("Oracle-Linux-7.9-20[0-9]*.*", source.source_name)) > 0], 0)
    source_type = data.oci_containerengine_node_pool_option.pool1_option.sources.0.source_type
    boot_volume_size_in_gbs = 60
  }
  ssh_public_key      = var.node_pool_ssh_public_key
}

data oci_containerengine_node_pool_option pool1_option {
    node_pool_option_id = oci_containerengine_cluster.oke-cluster.id
    compartment_id = var.compartment_ocid
}
