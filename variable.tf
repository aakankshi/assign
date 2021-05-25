variable "env" {
  description = "The environment name"
  type        = string
  default     = "dev"
  
}

variable "access_key" {
  type        = string
  description = "access KEY"

}
variable "secret_key" {
  type        = string
  description = "secret key."

}

variable "region" {
  type        = string
  description = "region"

}

#### EC2 variables ####

variable "jenkins_host_ami" {
  description = "ID of AMI Amazon linux to use for the instance"
  type        = string
  default     = "ami-0747bdcabd34c712a"
}

variable "jenkins_host_type" {
  description = "The type of instance to start"
  type        = string
  default     = "t3.micro"
  
}

variable "jenkins_host_tenancy" {
  description = "The tenancy of the instance (if the instance is running in a VPC). Available values: default, dedicated, host"
  type        = string
  default     = "default"
}

variable "jenkins_host_key_name" {
  description = "The key name to use for the instance"
  type        = string
  default     = "develop-gen-kp"
  
}

variable "jenkins_host_monitoring" {
  type        = bool
  description = "If true, the launched EC2 instance will have detailed monitoring enabled"
  default     = false
}

variable "jenkins_host_ebs_optimized" {
  type        = bool
  description = "If true, the launched EC2 instance will be EBS-optimized"
  default     = false
}

#### ec2-minikube variables ####

variable "minikube_host_ami" {
  description = "ID of AMI Amazon linux to use for the instance"
  type        = string
  default     = "ami-0747bdcabd34c712a"
}

variable "minikube_host_type" {
  description = "The type of instance to start"
  type        = string
  default     = "t3.micro"
  
}

variable "minikube_host_tenancy" {
  description = "The tenancy of the instance (if the instance is running in a VPC). Available values: default, dedicated, host"
  type        = string
  default     = "default"
}

variable "minikube_host_key_name" {
  description = "The key name to use for the instance"
  type        = string
  default     = "develop-gen-kp"
  
}

variable "minikube_host_monitoring" {
  type        = bool
  description = "If true, the launched EC2 instance will have detailed monitoring enabled"
  default     = false
}

variable "minikube_host_ebs_optimized" {
  type        = bool
  description = "If true, the launched EC2 instance will be EBS-optimized"
  default     = false
}


#### VPC variables ####

variable "vpc_cidr" {
  description = "cidr block for vpc"
  type        = string
  default     = "172.16.0.0/16"
}

variable "azs" {
  type        = list(string)
  description = "availability zone for vpc "
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = ["172.16.1.0/24"]
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = ["172.16.101.0/24"]
}

variable "enable_nat_gateway" {
  description = "Should be true if you want to provision NAT Gateways for each of your private networks"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Should be true if you want to provision a single shared NAT Gateway across all of your private networks"
  type        = bool
  default     = true
}

variable "one_nat_gateway" {
  description = "Should be true if you want to provision NAT Gateways for each of your AZ"
  type        = bool
  default     = false
}

variable "create_database_subnet_group" {
  description = "Controls if database subnet group should be created (n.b. database_subnets must also be set)"
  type        = bool
  default     = true
}
