/*  
    Terraform block 
    This is required to know which provider to download from Terraform Registry
    For more, check 
    https://learn.hashicorp.com/tutorials/terraform/aws-build?in=terraform/aws-get-started#terraform-block 
*/
terraform {
  required_providers {
    docker = {
      /*
        Shorthand for registry.terraform.io/kreuzwerker/docker, 
        more providers can be found in https://registry.terraform.io/browse/providers
      */
      source = "kreuzwerker/docker"
    }
  }
}

/*  
    Provider block 
    This configures the named provider, in our case aws. 
    Multiple provider blocks can exist to manage resources from different providers.
    For more, check https://learn.hashicorp.com/tutorials/terraform/aws-build?in=terraform/aws-get-started#providers
*/
provider "docker" {
  /* 
    Configuration options
    Credentials are taken from environment variables when profile is not specified
    For more, check https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication 
  */
}


/* 
    Resources block
    This block defines a piece of infrastructure. This can be physical like ec2 or logical like a REST API
    For more, check https://learn.hashicorp.com/tutorials/terraform/aws-build?in=terraform/aws-get-started#resources 
*/
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.latest
  name  = "example-nginx-server"
  ports {
    internal = 80
    external = 8077
  }
}
