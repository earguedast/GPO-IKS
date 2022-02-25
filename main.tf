provider "intersight" {
  apikey    = var.apikey
  secretkey = var.secretkey
  endpoint  = var.endpoint
}

module "iks_cluster" {
  source  = "terraform-cisco-modules/iks/intersight"
  version = "2.1.2"

  ip_pool = {
    use_existing        = true
    name                = "GPO-FSO-IKS-IP-POOL"
}

  sysconfig = {
    use_existing = true
    name         = "GPO-FSO-IKS-NODE-OS-CONFIG"
}

  k8s_network = {
    use_existing = true
    name         = "GPO-FSO-IKS-NETWORK-CIDR"  
  }
  # Version policy
  versionPolicy = {
    useExisting = true
    policyName         = "GPO-FSO-K8S-VERSION"
  }
    tr_policy = {
    use_existing = false
    create_new   = false
    name         = "trusted-registry"
  }
  runtime_policy = {
    use_existing = false
    create_new   = false
    # name                 = "runtime"
    # http_proxy_hostname  = "t"
    # http_proxy_port      = 80
    # http_proxy_protocol  = "http"
    # http_proxy_username  = null
    # http_proxy_password  = null
    # https_proxy_hostname = "t"
    # https_proxy_port     = 8080
    # https_proxy_protocol = "https"
    # https_proxy_username = null
    # https_proxy_password = null
  }

  # Infra Config Policy Information
  infraConfigPolicy = {
    use_existing     = true
    policyName             = "GPO-FSO-VM-INFRA-CONFIG-2401"
}

  instance_type = {
    use_existing = true
    name         = "GPO-FSO-VM-INSTANCE-TYPE-IKS"
  }    
  # Cluster information
  cluster = {
    name                = var.cluster_name
    action              = "Deploy"
    wait_for_completion = false
    worker_nodes        = 2
    load_balancers      = 1
    worker_max          = 3
    control_nodes       = 1
    ssh_user            = "iksadmin"
    ssh_public_key      = var.sshkey
  }
  # Organization and Tag
  organization = var.organization
  tags         = var.tags
}
