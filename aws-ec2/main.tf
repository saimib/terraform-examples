/*  
    Terraform block 
    This is required to know which provider to download from Terraform Registry
    For more, check 
    https://learn.hashicorp.com/tutorials/terraform/aws-build?in=terraform/aws-get-started#terraform-block 
*/
terraform {
  backend "s3" {
    bucket = "tf-example-backend"
    key    = "terraform/example"
    region = "eu-west-2"
  }
  required_providers {
    aws = {
      /* 
        Shorthand for registry.terraform.io/hashicorp/aws, 
        more providers can be found in https://registry.terraform.io/browse/providers
      */
      source  = "hashicorp/aws"
      version = "~> 3.27" // Version is optional but recommended to avoid breaking changes
    }
  }
}


/*  
    Provider block 
    This configures the named provider, in our case aws. 
    Multiple provider blocks can exist to manage resources from different providers.
    For more, check https://learn.hashicorp.com/tutorials/terraform/aws-build?in=terraform/aws-get-started#providers
*/
provider "aws" {
  /* 
    Configuration options
    Credentials are taken from environment variables when profile is not specified
    For more, check https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication 
  */
  region = "eu-west-2"
}


/* 
    Resources block
    This block defines a piece of infrastructure. This can be physical like ec2 or logical like a REST API
    For more, check https://learn.hashicorp.com/tutorials/terraform/aws-build?in=terraform/aws-get-started#resources 
*/
resource "aws_instance" "example" {
  ami           = "ami-0ff4c8fb495a5a50d"
  instance_type = "t2.micro"

  tags = {
    Name = var.instance_name
  }
}
