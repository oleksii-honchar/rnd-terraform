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

# First synth & S3 backend
The truth is, that you need to have S3 bucket to be created before use it for S3 Backend. So in order to have Global state backed also saved in the same bucket here is a workaround:

- When starting working with project - you want to have global state bucket for all stacks
- You can do it using `cdktf deploy GlobalS3State`, but you need to comment `S3Backend` lines first
- So when deploy `GlobalS3State` with `S3Backend` creation commented, it will create necessary bucket and its properties
- Currently, your state is `local` by default. you can check state file in root folder. In order to move it to S3, do the following:
  - uncomment `S3Backend` creation code, and generate tf json
    ```bash
    cdktf synth GlobalS3State
    ```
  - now you need to re-init tf
    ```bash
    cd cdktf.out/stacks/GlobalS3State
    tf init -migrate-state
    # answer "yes" when asked to copy current state to S3
    ```
- That's it. Now you can check you bucket for remote state file. And safely remove local one.
- Now you can continue to use `cdktf`

# Development

- Compose all your stacks in App (main.ts)
- Describe constructs and stacks in corresponding folders
- Apply code
  ```bash
  cdktf plan
  cdktf synth
  ```
- Check stacks state: `make tf-show stack=GlobalS3State`
  - use exactly that string which was used for stack creation, e.g. `new GlobalS3StateStack(app, "GlobalS3State");`