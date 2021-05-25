locals {
  user_data = <<EOF
#! /bin/bash
sudo apt update
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update
sudo apt install jenkins
sudo systemctl start jenkins
sudo ufw allow 8080
sudo ufw status
EOF
}

module "ec2-jenkins" {
  source                      = "terraform-aws-modules/ec2-instance/aws"
  version                     = "2.15.0"
  name                        = "${var.env}-jenkins-host"
  ami                         = var.jenkins_host_ami
  //associate_public_ip_address = var.bastion_associate_public_ip_address
  instance_type               = var.jenkins_host_type
  tenancy                     = var.jenkins_host_tenancy
  vpc_security_group_ids      = [module.sg-bastion-ssh.this_security_group_id]
  subnet_ids                  = module.vpc.public_subnets
  key_name                    = var.jenkins_host_key_name
  monitoring                  = var.jenkins_host_monitoring
  ebs_optimized               = var.jenkins_host_ebs_optimized
  user_data_base64            = base64encode(local.user_data)
  associate_public_ip_address = true
  tags = {
    name         = "${var.env}-jenkins-host"
    environment  = var.env
    "created by" = "terraform"
  }
}

locals {
  user_data = <<EOF
#! /bin/bash
sudo apt update
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update
sudo apt install jenkins
sudo systemctl start jenkins
sudo ufw allow 8080
sudo ufw status
EOF
}

module "ec2-minikube" {
  source                      = "terraform-aws-modules/ec2-instance/aws"
  version                     = "2.15.0"
  name                        = "${var.env}-minikube-host"
  ami                         = var.minikube_host_ami
  //associate_public_ip_address = var.bastion_associate_public_ip_address
  instance_type               = var.minikube_host_type
  tenancy                     = var.minikube_host_tenancy
  vpc_security_group_ids      = [module.sg-bastion-ssh.this_security_group_id]
  subnet_ids                  = module.vpc.public_subnets
  key_name                    = var.minikube_host_key_name
  monitoring                  = var.minikube_host_monitoring
  ebs_optimized               = var.minikube_host_ebs_optimized
  user_data_base64            = base64encode(local.user_data)
  associate_public_ip_address = true
  tags = {
    name         = "${var.env}-minikube-host"
    environment  = var.env
    "created by" = "terraform"
  }
}