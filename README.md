# Azure Container Instances with CI/CD pipeline

CRUD service programmed in Rust with Axum deployed to Azure Container Instances by GitHub Actions Workflow CI/CD pipeline.
Repository pushes will trigger a workflow which builds a docker container based on supplied Dockerfile and
transmits it to Azure Container Registry (ACR). The associated container is then deployed to Azure Container Instances.
Since ACI subscribes to a specific image, subsequent pushes will effectively overwrite the current deployment.


## Requirements

* x86-64
* Linux/Unix
* [Rust](https://www.rust-lang.org/tools/install)
* [Docker](https://www.docker.com/products/docker-desktop/)

## Creating resources

The shell script 'up' allocates Azure resources with Terraform.

## Deleting resources

The shell script 'down' deallocates Azure resources.


## Guide

### 1. Provision Azure Resources

- Run the 'up' script to provision Azure resources.

### 2. Access Azure Portal

- Open your browser and navigate to the Azure Portal.

### 3. Container Registry Setup

- Go to the newly provisioned Container Registry named 'hvalfangstcontainerregistry'.
- Click on 'Access keys' under the 'Settings' section.
- Copy the registry name and password for future use.

### 4. Microsoft Entra ID Setup

- Navigate to 'Microsoft Entra ID' using the search bar.
- Click on 'Add' and choose 'App registration'.
- Set name to 'hvalfangst-aci', account option to 'Single tenant', and click 'Register'.
- Go to the overview of the newly created app registration 'hvalfangst-aci'.
- Copy values associated with Application (client) ID and Directory (tenant) ID for future use.
- Navigate to 'Certificates & secrets' under 'Manage'.
- Click 'Add credential' under 'Federated credentials'.
- Choose the scenario: 'GitHub Actions deploying Azure resources'.
- Set GitHub account name and Repo name.
- Set Entity type to 'Environment' and the associated value to 'Production'.
- Set a fitting name, such as 'hvalfangst-devops-credential' under Credential detail name.

### 5. Subscription Setup

- Navigate to your subscription, which holds your provisioned resource group.
- Copy your subscription ID for future use.
- Click on 'Add' under 'Access control (IAM)' and pick 'role assignment'.
- Choose the role 'Contributor' under 'Privileged administrator roles'.
- Navigate to the 'Members' section and click 'Select members'.
- Search for the app registration 'hvalfangst-aci' and assign the role.

### 6. GitHub Repository Secrets

- Open the 'Settings' tab of your GitHub repository.
- Click on 'Actions' under 'Security' -> 'Secrets and variables'.
- Create the following repository secrets:
    - ACR_USERNAME: Value copied in step #3
    - ACR_PASSWORD: Value copied in step #3
    - AZURE_CLIENT_ID: Value copied in step #4
    - AZURE_TENANT_ID: Value copied in step #4
    - AZURE_SUBSCRIPTION_ID: Value copied in step #5

### 7. Deploy Workflow

The GitHub Actions workflow will automatically build, package, and deploy new versions of the app to your Azure environment on repository pushes.


