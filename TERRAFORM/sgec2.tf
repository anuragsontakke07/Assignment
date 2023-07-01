module "bastion_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "bastion security group"
  description = "opening port 22 for ssh"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "User-service ports"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
  egress_rules = ["all-all"]
  egress_cidr_blocks = ["0.0.0.0/0"]
}


resource "aws_instance" "bastion_host" {
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t3.small"
  key_name      = "aws-key"
  subnet_id     = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.bastion_sg.security_group_id]
  associate_public_ip_address = true

  tags = {
    Name = "Bastion"
  }

}

module "jenkins_sg1" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "Jenkins security group"
  description = "opening all ports"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 65535
      protocol    = "tcp"
      description = "All ports"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
  egress_rules = ["all-all"]
  egress_cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_instance" "Jenkins_host" {
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t3.medium"
  key_name      = "aws-key"
  subnet_id     = module.vpc.private_subnets[0]
  vpc_security_group_ids = [module.jenkins_sg1.security_group_id]


  tags = {
    Name = "Jenkins"
  }

}

module "app_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "application security group"
  description = "opening all ports"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 65535
      protocol    = "tcp"
      description = "All ports"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
  egress_rules = ["all-all"]
  egress_cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_instance" "Apps_host" {
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t3.small"
  key_name      = "aws-key"
  subnet_id     = module.vpc.private_subnets[1]
  vpc_security_group_ids = [module.app_sg.security_group_id]


  tags = {
    Name = "Application"
  }

}