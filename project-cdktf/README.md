project-cdktf
---

# Overview

This a template for project CDKTF configuration. `Project` here mean set of application both BE & FE and supporting infra, local or cloud. Current project has:
- global state S3 bucket with folders
- s3 bucket for static files
- static files copied to bucket on change

# Installation for new cdktf project

- Node.js (via nvm) ([src](https://github.com/nvm-sh/nvm#installing-and-updating))
    ```bash 
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
    nvm install 20
    node -v > .nvmrc
    ```
  - [optionally] auto-call `nvm use` on `cd <dir>` ([src](https://github.com/nvm-sh/nvm#zsh))

- Terraform ([src](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli))
    ```bash
    brew tap hashicorp/tap
    brew install hashicorp/tap/terraform
    brew update
    brew upgrade hashicorp/tap/terraform
    touch ~/.zshrc
    terraform -install-autocomplete
    echo "alias tf='terraform'" >> ~/.zshrc
    ```
- CDKTF ([src](https://developer.hashicorp.com/terraform/tutorials/cdktf/cdktf-install#install-cdktf))
    ```bash
    npm install --global cdktf-cli@latest
    cdktf init --template="typescript" --providers="aws@~>4.0"
    ```