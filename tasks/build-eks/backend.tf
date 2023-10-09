terraform {

  backend "s3" {
    bucket         = "datamesh-accelerator-terraform-state-182174426630"
    key            = "datamesh_eks_environment.tfstate"
    region         = "us-east-2"
    dynamodb_table = "datamesh-accelerator-terraform-lock"
  }

}