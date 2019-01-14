variable "dcos_install_mode" {
  description = "specifies command type to execute: install or upgrade"
  default     = "install"
}

# Identify the DC/OS cluster public IP for forwarding rules.
data "http" "whatismyip" {
  url = "http://whatismyip.akamai.com/"
}

module "dcos" {
  source = "dcos-terraform/dcos/aws"

  dcos_instance_os    = "centos_7.4"
  cluster_name        = "JupyterLab"
  ssh_public_key_file = "~/.ssh/id_rsa.pub"
  admin_ips           = ["${data.http.whatismyip.body}/32"]

  num_masters        = "1"
  num_public_agents  = "1"
  num_private_agents = "5"

  public_agents_instance_type = "m4.xlarge"      # or m5.xlarge and larger
  private_agents_instance_type = "m4.xlarge"     # or m5.xlarge and larger

  dcos_version = "1.12.1"
  dcos_variant = "ee"
  # dcos_license_key_contents = "${file("./license.txt")}"

  dcos_install_mode = "${var.dcos_install_mode}"
}

output "masters-ips" {
  value = "${module.dcos.masters-ips}"
}

output "cluster-address" {
  value = "${module.dcos.masters-loadbalancer}"
}

output "public-agents-loadbalancer" {
  value = "${module.dcos.public-agents-loadbalancer}"
}
