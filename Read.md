# Terraform Lifecycle Management – AWS

## Project Overview

This project demonstrates how to create AWS infrastructure using Terraform and understand Lifecycle Management and Drift Detection.

## Objectives

1. Create an AWS VPC.
2. Create two subnets: SUBNET-A and SUBNET-B.
3. Create one EC2 instance in each subnet.
4. Implement `prevent_destroy` lifecycle rule.
5. Implement `ignore_changes` lifecycle rule.
6. Modify resources manually in AWS Console.
7. Detect infrastructure drift using Terraform.

## Architecture

```text
                 AWS CLOUD
                     |
                LIFECYCLE-VPC
                10.0.0.0/16
                     |
           ---------------------
           |                   |
       SUBNET-A             SUBNET-B
      10.0.1.0/24          10.0.2.0/24
           |                   |
        SERVER-A             SERVER-B
        t3.micro             t3.micro
```

## Technologies Used

- AWS
- Terraform
- AWS VPC
- AWS EC2
- Terraform Lifecycle Rules

## AWS Configuration

| Component | Configuration |
|---|---|
| Region | ap-southeast-2 |
| VPC CIDR | 10.0.0.0/16 |
| Subnet-A | 10.0.1.0/24 |
| Subnet-B | 10.0.2.0/24 |
| EC2 Instance Type | t3.micro |
| Operating System | Amazon Linux 2023 |

## Terraform Lifecycle Rules

### 1. Prevent Destroy

```hcl
lifecycle {
  prevent_destroy = true
}
```

- Prevents Terraform from destroying the protected resource.
- Helps avoid accidental deletion of important infrastructure.

### 2. Ignore Changes

```hcl
lifecycle {
  ignore_changes = [tags]
}
```

- Ignores changes made to resource tags outside Terraform.
- Terraform will not try to revert those tag changes.

## Drift Detection

Drift occurs when actual AWS infrastructure is different from the Terraform configuration or recorded state.

### Practical Test

1. Modify SERVER-A tags manually in AWS Console.
2. Run `terraform plan`.
3. Terraform ignores the tag changes because of `ignore_changes`.

Next:

1. Modify SUBNET-A tags manually in AWS Console.
2. Run `terraform plan`.
3. Terraform detects the changes because subnet tags are not ignored.
4. Run `terraform apply` to restore the original configuration.

## Terraform Commands

```bash
terraform init
terraform validate
terraform plan
terraform apply
terraform plan -destroy
terraform destroy
```

| Command | Purpose |
|---|---|
| init | Initialize Terraform |
| validate | Validate configuration |
| plan | Preview infrastructure changes |
| apply | Create or update resources |
| plan -destroy | Preview destruction |
| destroy | Delete managed infrastructure |

## Key Learnings

- Creating VPC and multiple subnets using Terraform.
- Deploying EC2 instances in different subnets.
- Understanding Terraform lifecycle rules.
- Protecting resources using `prevent_destroy`.
- Ignoring selected changes using `ignore_changes`.
- Identifying infrastructure drift.
- Managing AWS infrastructure through Terraform.

## Cleanup

Before destroying resources:

1. Remove `prevent_destroy = true` from both EC2 lifecycle blocks.
2. Run `terraform apply`.
3. Run `terraform destroy`.
4. Confirm deletion of all lab resources in AWS Console.

## Conclusion

Successfully created AWS infrastructure using Terraform and explored lifecycle management, resource protection, ignored changes and infrastructure drift detection.