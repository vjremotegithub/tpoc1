# Terragrunt is a thin wrapper for Terraform that provides extra tools for working with multiple Terraform modules,
# remote state, and locking: https://github.com/gruntwork-io/terragrunt
terragrunt = {
  # Configure Terragrunt to automatically store tfstate files in an S3 bucket
  remote_state {
    backend = "s3"
    config {
      encrypt        = true
      bucket         = "tpoc1-state-global-snd"
      key            = "snd/terraform.tfstate"
      region         = "eu-west-1"
      dynamodb_table = "tpoc1-locks"
    }
  }
  
  
   s3_bucket_tags {
        owner = "terragrunt integration test"
        name  = "Terraform state storage"
      }

    dynamodb_table_tags {
        owner = "terragrunt integration test"
        name  = "Terraform lock table"
      }
  
 aws_region = "eu-west-1"
shared_credentials_file= "/home/vijay/.aws/credentials"
aws_profile                  = "snd-profile"    
      
  # Configure root level variables that all resources can inherit
  terraform {
    extra_arguments "bucket" {
      commands = ["${get_terraform_commands_that_need_vars()}"]
      optional_var_files = [
          "${get_tfvars_dir()}/${find_in_parent_folders("account.tfvars", "ignore")}"
      ]
    }
  }
}



