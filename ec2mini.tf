locals {
  user_data_minikube = <<EOF
#! /bin/bash
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y 
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update
apt-cache policy docker-ce
sudo apt install docker-ce -y
sudo apt-get update -y && sudo apt-get upgrade -y
sudo apt-get install curl &&  sudo apt-get install apt-transport-https
wget http://download.virtualbox.org/virtualbox/5.2.0/Oracle_VM_VirtualBox_Extension_Pack-5.2.0.vbox-extpack
echo "y" | sudo VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-5.2.0.vbox-extpack --accept-license=b674970f720eb020ad18926a9268607089cc1703908696d24a04aa870f34c8e8
sudo apt-get install virtualbox-dkms -y 
sudo dpkg-reconfigure virtualbox-dkms  && sudo dpkg-reconfigure virtualbox
wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo cp minikube-linux-amd64 /usr/local/bin/minikube
sudo chmod 755 /usr/local/bin/minikube
minikube start --extra-config=kubeadm.ignore-preflight-errors=NumCPU --force --cpus 1  --no-vtx-check
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
  subnet_ids                  = module.vpc.private_subnets
  key_name                    = var.minikube_host_key_name
  monitoring                  = var.minikube_host_monitoring
  ebs_optimized               = var.minikube_host_ebs_optimized
  user_data_base64            = base64encode(local.user_data_minikube)
  associate_public_ip_address = true
  tags = {
    name         = "${var.env}-minikube-host"
    environment  = var.env
    "created by" = "terraform"
  }
}