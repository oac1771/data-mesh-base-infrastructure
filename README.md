# DATA MESH BASE INFRASTRUCTURE

This small project creates the base infrastructure for a TW Data Mesh Accelerator in AWS.


## Installation REQUIREMENTS

1. [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
2. [Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
3. [Taskfile](https://taskfile.dev/installation/)
4. [docker](https://docs.docker.com/engine/install/)


## BOOTSTRAP INFRASTRUCTURE
Creates the Terraform S3 Backend for EKS resources


### Authentication

Authenticate to [ghcr.io](https://github.com/twlabs/data-mesh-deployment-environment-images#local-development) to pull deployment enviornment 

#### Assume AWS Admin Role
Create datamesh-base-admin profile and assume admin role using sso

```
PROFILE_NAME=datamesh-base-admin

aws configure set --profile "$PROFILE_NAME" sso_start_url "https://d-99672c8a5f.awsapps.com/start#/"
aws configure set --profile "$PROFILE_NAME" sso_region "eu-central-1"
aws configure set --profile "$PROFILE_NAME" sso_account_id "182174426630"
aws configure set --profile "$PROFILE_NAME" region "us-east-2"
aws configure set --profile "$PROFILE_NAME" sso_role_name "Admin-Account-Access"

aws sso login --profile $PROFILE_NAME
export AWS_DEFAULT_PROFILE=$PROFILE_NAME
```


### Bootstrap

create s3 backend for eks resources
```
task bootstrap-eks AWS_ADMIN_PROFILE=datamesh-base-admin
```

### Build EKS Resources

Push commit to trigger [build-eks pipeline](https://github.com/twlabs/data-mesh-base-infrastructure/blob/main/.github/workflows/deploy.yml)

### Refactor Ideas:
   - move k8/aws-auth management from Taskfile (eks create ...) into eks terraform module (manage_aws_auth_configmap var in eks module)