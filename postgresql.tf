module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "demodb"

  engine            = "postgresql"
  engine_version    = "12.7"
  instance_class    = "db.t3a.large"
  allocated_storage = 5

  db_name  = "demodb"
  username = "user"
  port     = "5432"  # PostgreSQL default port

  iam_database_authentication_enabled = true

  vpc_security_group_ids = [module.web_server_sg.security_group_id]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  # Enhanced Monitoring - see example for details on how to create the role
  # by yourself, in case you don't want to create it automatically
  monitoring_interval    = "30"
  monitoring_role_name   = "MyRDSMonitoringRole"
  create_monitoring_role = true

  tags = {
    Owner       = "user"
    Environment = "dev"
  }

  # DB subnet group
  create_db_subnet_group = true
  subnet_ids             = ["module.vpc.public_subnets[0]", "module.vpc.public_subnets[1]"]

  # DB parameter group
  family = "postgres12"

  # DB option group
  major_engine_version = "12"

  # Database Deletion Protection
  deletion_protection = true

  parameters = [
    {
      name  = "client_encoding"
      value = "UTF8"
    },
    {
      name  = "lc_collate"
      value = "en_US.UTF-8"
    },
    {
      name  = "lc_ctype"
      value = "en_US.UTF-8"
    }
  ]

  options = [
    {
      option_name = "postgres-logical-replication"

      option_settings = [
        {
          name  = "rds.logical_replication"
          value = "1"
        }
      ]
    }
  ]
}
