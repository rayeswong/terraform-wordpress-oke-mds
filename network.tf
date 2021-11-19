resource oci_core_vcn oke-vcn {
  cidr_block     = "10.0.0.0/16"
  compartment_id = var.compartment_ocid
  defined_tags = {
  }
  display_name = "oke-vcn"
  dns_label    = "ocidevcluster"
  freeform_tags = {
  }
  
}

resource oci_core_internet_gateway oke-igw {
  compartment_id = var.compartment_ocid
  defined_tags = {
  }
  display_name = "oke-igw"
  enabled      = "true"
  freeform_tags = {
  }
  vcn_id = oci_core_vcn.oke-vcn.id
}

resource oci_core_subnet oke-subnet-regional {
  
  cidr_block     = "10.0.10.0/24"
  compartment_id = var.compartment_ocid
  defined_tags = {
  }
  dhcp_options_id = oci_core_vcn.oke-vcn.default_dhcp_options_id
  display_name    = "oke-subnet-regional"
  dns_label       = "okesubnet"
  freeform_tags = {
  }
  
  prohibit_public_ip_on_vnic = "false"
  route_table_id             = oci_core_vcn.oke-vcn.default_route_table_id
  security_list_ids = [
    oci_core_security_list.oke-seclist.id,
  ]
  vcn_id = oci_core_vcn.oke-vcn.id
}
resource oci_core_subnet oke-svclbsubnet-regional {
  
  cidr_block     = "10.0.20.0/24"
  compartment_id = var.compartment_ocid
  defined_tags = {
  }
  dhcp_options_id = oci_core_vcn.oke-vcn.default_dhcp_options_id
  display_name    = "oke-svclbsubnet-regional"
  dns_label       = "okelbsubnet"
  freeform_tags = {
  }
  
  prohibit_public_ip_on_vnic = "false"
  route_table_id             = oci_core_vcn.oke-vcn.default_route_table_id
  security_list_ids = [
    oci_core_vcn.oke-vcn.default_security_list_id,
  ]
  vcn_id = oci_core_vcn.oke-vcn.id
}
resource oci_core_subnet mds-subnet-regional {
  
  cidr_block     = "10.0.30.0/24"
  compartment_id = var.compartment_ocid
  defined_tags = {
  }
  dhcp_options_id = oci_core_vcn.oke-vcn.default_dhcp_options_id
  display_name    = "mds-subnet-regional"
  dns_label       = "mdssubnet"
  freeform_tags = {
  }
  
  prohibit_public_ip_on_vnic = "true"
  route_table_id             = oci_core_vcn.oke-vcn.default_route_table_id
  security_list_ids = [
    oci_core_security_list.mds-seclist.id,
  ]
  vcn_id = oci_core_vcn.oke-vcn.id
}

resource oci_core_subnet operator-subnet-regional {
  
  cidr_block     = "10.0.40.0/24"
  compartment_id = var.compartment_ocid
  defined_tags = {
  }
  dhcp_options_id = oci_core_vcn.oke-vcn.default_dhcp_options_id
  display_name    = "operator-subnet-regional"
  dns_label       = "operatorsubnet"
  freeform_tags = {
  }
  
  prohibit_public_ip_on_vnic = "false"
  route_table_id             = oci_core_vcn.oke-vcn.default_route_table_id
  security_list_ids = [
    oci_core_security_list.operator-seclist.id,
  ]
  vcn_id = oci_core_vcn.oke-vcn.id
}

resource oci_core_default_dhcp_options Default-DHCP-Options-for-oke-vcn {
  defined_tags = {
  }
  display_name = "Default DHCP Options for oke-vcn"
  freeform_tags = {
  }
  manage_default_resource_id = oci_core_vcn.oke-vcn.default_dhcp_options_id
  options {
    custom_dns_servers = [
    ]
    
    server_type = "VcnLocalPlusInternet"
    type        = "DomainNameServer"
  }
  options {
    
    search_domain_names = [
      "ocidevcluster.oraclevcn.com",
    ]
    
    type = "SearchDomain"
  }
}
resource oci_core_default_route_table oke-routetable {
  defined_tags = {
  }
  display_name = "oke-routetable"
  freeform_tags = {
  }
  manage_default_resource_id = oci_core_vcn.oke-vcn.default_route_table_id
  route_rules {
    
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.oke-igw.id
  }
}
resource oci_core_security_list oke-seclist {
  compartment_id = var.compartment_ocid
  defined_tags = {
  }
  display_name = "oke-seclist"

  egress_security_rules {
    
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    
    protocol  = "all"
    stateless = "false"
    
  }
  freeform_tags = {
  }
  ingress_security_rules {
    
    protocol    = "all"
    source      = "10.0.10.0/24"
    source_type = "CIDR_BLOCK"
    stateless   = "true"
    
  }
  ingress_security_rules {
    
    protocol    = "all"
    source      = "10.0.20.0/24"
    source_type = "CIDR_BLOCK"
    stateless   = "true"
    
  }
  ingress_security_rules {
    
    protocol    = "all"
    source      = "10.0.40.0/24"
    source_type = "CIDR_BLOCK"
    stateless   = "true"
    
  }
  ingress_security_rules {
    
    icmp_options {
      code = "4"
      type = "3"
    }
    protocol    = "1"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    stateless   = "false"
    
  }
  ingress_security_rules {
    
    protocol    = "6"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    stateless   = "false"
    tcp_options {
      max = "22"
      min = "22"
      
    }
    
  }
  vcn_id = oci_core_vcn.oke-vcn.id
}
resource oci_core_default_security_list oke-svclbseclist {
  defined_tags = {
  }
  display_name = "oke-svclbseclist"
  egress_security_rules {
    
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    
    protocol  = "6"
    stateless = "true"
    
  }
  freeform_tags = {
  }
  ingress_security_rules {
    
    protocol    = "6"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    stateless   = "true"
    
  }
  manage_default_resource_id = oci_core_vcn.oke-vcn.default_security_list_id
}
resource oci_core_security_list mds-seclist {
  compartment_id = var.compartment_ocid
  defined_tags = {
  }
  display_name = "mds-seclist"

  egress_security_rules {
    
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    
    protocol  = "all"
    stateless = "false"
    
  }
  freeform_tags = {
  }
  ingress_security_rules {
    
    protocol    = "all"
    source      = "10.0.10.0/24"
    source_type = "CIDR_BLOCK"
    stateless   = "true"
    
  }
  ingress_security_rules {
    
    protocol    = "all"
    source      = "10.0.20.0/24"
    source_type = "CIDR_BLOCK"
    stateless   = "true"
    
  }
  ingress_security_rules {
    
    protocol    = "all"
    source      = "10.0.40.0/24"
    source_type = "CIDR_BLOCK"
    stateless   = "true"
    
  }
  ingress_security_rules {
    
    icmp_options {
      code = "4"
      type = "3"
    }
    protocol    = "1"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    stateless   = "false"
    
  }
  vcn_id = oci_core_vcn.oke-vcn.id
}

resource oci_core_security_list operator-seclist {
  compartment_id = var.compartment_ocid
  defined_tags = {
  }
  display_name = "operator-seclist"

  egress_security_rules {
    
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    
    protocol  = "all"
    stateless = "false"
    
  }
  freeform_tags = {
  }
  ingress_security_rules {
    
    icmp_options {
      code = "4"
      type = "3"
    }
    protocol    = "1"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    stateless   = "false"
    
  }
  ingress_security_rules {
    
    protocol    = "6"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    stateless   = "false"
    tcp_options {
      max = "22"
      min = "22"
      
    }
    
  }
  vcn_id = oci_core_vcn.oke-vcn.id
}

