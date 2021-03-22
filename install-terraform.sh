# Installation instrctions for Terraform on Debian bases linux distros
# To install on different machines check https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started


# Add the HashiCorp GPG key. For more information on GPG Keys, check https://gnupg.org/
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -

# Add the official HashiCorp Linux repository
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

# Update repository
sudo apt update

# Install terraform
sudo apt install terraform

# Verify installation
terraform -help

# Enable tab completion
terraform -install-autocomplete