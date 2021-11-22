locals {
  tags = {
      created_by = "RafaelFalcão@Mindera"
  }

  aws_ecr_url = "${data.aws_caller_identity.currentuser.account_id}.dkr.ecr.eu-west-2.amazonaws.com"
}