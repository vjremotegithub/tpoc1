# Root level variables that all modules can inherit. This is especially helpful with multi-account configs
# where terraform_remote_state data sources are placed directly into the modules.

tfstate_global_bucket        = "tpoc1-state-global-snd"
tfstate_global_bucket_region = "eu-west-1"
aws_region = "eu-west-1"
aws_profile                  = "snd-profile"
shared_credentials_file= "/home/vijay/.aws/credentials"
