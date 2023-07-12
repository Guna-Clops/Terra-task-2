module "sns_topic" {
  source  = "terraform-aws-modules/sns/aws"

  name  = "simple"

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}