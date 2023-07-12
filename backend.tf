terraform {
  backend "s3" {
    bucket         = "terraform-s3-module"   // replace with your bucketname
    dynamodb_table = "dev"   // create a Dynamo Db table and mention here
    key            = "dev/terraform.tfstate" // inside bucket create the file
    region         = "us-east-2"  
  }
}