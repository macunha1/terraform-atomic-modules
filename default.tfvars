cidr_block = "10.0.0.0/8"

default_amis = {
  fedora_cloud_28 = {
    name  = "Fedora-Cloud-Base-28-1.1.x86_64-hvm-us-east-1-gp2-0"
    owner = "125523088429"
  }

  debian = {
    name  = "debian-jessie-amd64-hvm-2016-11-13-1356-ebs"
    owner = "379101102735"
  }

  amazon_linux_2 = {
    name  = "amzn2-ami-hvm-2.0.20180810-x86_64-gp2"
    owner = "137112412989"
  }
}
