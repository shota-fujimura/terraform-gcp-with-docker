alias ll='ls -la --color'
alias tf='terraform'

# init
alias init:dev="cd /terraform/src/environment/dev && terraform init && cd ../../../.."
alias init:staging="cd /terraform/src/environment/staging && terraform init && cd ../../../.."
alias init:prod="cd /terraform/src/environment/prod && terraform init && cd ../../../.."

# plan
alias plan:dev="cd /terraform/src/environment/dev && terraform plan -var-file=./dev.tfvars && cd ../../../.."
alias plan:staging="cd /terraform/src/environment/staging && terraform plan -var-file=./staging.tfvars && cd ../../../.."
alias plan:prod="cd /terraform/src/environment/prod && terraform plan -var-file=./prod.tfvars && cd ../../../.."

# apply
alias apply:dev="cd /terraform/src/environment/dev && terraform apply -var-file=./dev.tfvars && cd ../../../.."
alias apply:staging="cd /terraform/src/environment/staging && terraform apply -var-file=./staging.tfvars && cd ../../../.."
alias apply:prod="cd /terraform/src/environment/prod && terraform apply -var-file=./prod.tfvars && cd ../../../.."

# destroy
alias destroy:dev="cd /terraform/src/environment/dev && terraform destroy -var-file=./dev.tfvars && cd ../../../.."
alias destroy:staging="cd /terraform/src/environment/staging && terraform destroy -var-file=./staging.tfvars && cd ../../../.."
alias destroy:prod="cd /terraform/src/environment/prod && terraform destroy -var-file=./prod.tfvars && cd ../../../.."

# fmt
alias fmt="terraform fmt -recursive"