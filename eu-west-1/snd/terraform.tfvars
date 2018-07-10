# Terragrunt is a thin wrapper for Terraform that provides extra tools for working with multiple Terraform modules,
# remote state, and locking: https://github.com/gruntwork-io/terragrunt
terragrunt = {
  # Configure Terragrunt to automatically store tfstate files in an S3 bucket
  remote_state {
    backend = "s3"
    config {
      encrypt        = true
      bucket         = "tpoc1-state-global-snd"
      key            = "terraform.tfstate"
      region         = "eu-west-1"
      profile = "snd-profile"
      shared_credentials_file= "/home/vijay/.aws/credentials"
      dynamodb_table = "tpoc1-locks"
    }
  }
  


# Configure root level variables that all resources can inherit
  terraform {
    extra_arguments "bucket" {
      commands = ["${get_terraform_commands_that_need_vars()}"]
      optional_var_files = [
          "${get_tfvars_dir()}/${find_in_parent_folders("account.tfvars", "ignore")}"
      ]
    }
    
 aws_region = "eu-west-1"
aws_profile = "snd-profile"
shared_credentials_file= "/home/vijay/.aws/credentials" 
    
  }
}



