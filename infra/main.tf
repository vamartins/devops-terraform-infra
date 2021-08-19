module "main" {
  source                 = "./resources"
  region                 = var.region
  az                     = var.az
  vpc_cidr_block         = var.vpc_cidr_block
  subnet_public_cidr     = var.subnet_public_cidr
  public_dest_cidr_block = var.public_dest_cidr_block
  sg_public_ports        = var.sg_public_ports
  http_port              = var.http_port
  https_port             = var.https_port
  ssh_port               = var.ssh_port
  icmp_port              = var.icmp_port
  initial_port           = var.initial_port
  final_port             = var.final_port
  tcp_protocol           = var.tcp_protocol
  icmp_protocol          = var.icmp_protocol
  all_protocols          = var.all_protocols
  tui_user               = var.tui_user
  iam_ro_policy          = var.iam_ro_policy
  kp_tui_user            = var.kp_tui_user
  instance_type          = var.instance_type
  ec2-user               = var.ec2-user
}