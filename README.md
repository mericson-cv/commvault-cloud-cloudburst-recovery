![Commvault Backup & Recovery](https://media.licdn.com/dms/image/C4E0BAQHatJ6EtVFZlQ/company-logo_200_200/0/1655393666027?e=1698883200&v=beta&t=WLBL8ERyPVlKWEgjHC2qIPZlsdJejA_bP1K6z12P3m4)

# Commvault Backup & Recovery - Massively Parallel Recovery Example

Example Infrastructure as Code (IaC) solution using Amazon CloudFormation, HashiCorp Terraform to deploy on-demand Amazon EC2 instances to perform a massively parallel recovery using Commvault Backup & Recovery.

## :books: Background

[Commvault Backup & Recovery](https://www.commvault.com/aws) is the industry leading data protection and cyber-resilience solution from AWS services, SaaS, and hybrid workloads. You can use Commvault Backup & Recovery to secure, defend, and recover your business applications and data.

This example solution show-cases the elasticity of Amazon EC2, the scalability of Amazon S3, and the power of the Commvault Backup & Recovery data platform to achieve a massivelly parallel restore with on-demand ephemeral resources deployed using Infrastructure as Code.

A part of any modern data management plan includes an understanding of your business _recovery time objectives_ and in extereme circumstances where multiple applications are affected, the elastic nature of AWS compute allows a rapid and **cost effective** rapid recovery solution.

![Commvault Massively Parallel Restore - Reference Architecture](https://github.com/mericson-cv/aws-massively-parallel-recovery-solution/blob/main/commvault-massively-parallel-recovery-solution.png)

## :hammer_and_wrench: Setup

At a high-level the process for setup and execution this solution is:
1. Deploy [Commvault Backup & Recovery BYOL](https://aws.amazon.com/marketplace/pp/prodview-ecysdywnipxv6?sr=0-3&ref_=beagle&applicationId=AWSMPContessa) from the [AWS Marketplace](https://aws.amazon.com/marketplace/seller-profile?id=88cecb14-a8b2-49bd-ba1f-58be76108f48) and complete the [Core Setup Wizard](https://documentation.commvault.com/2023e/essential/86625_quick_start_guide.html#step-3-complete-core-setup-wizard).
2. Configure and perform backup of your Amazon EC2 instances and/or other [supported workloads](https://www.commvault.com/supported-technologies/amazon/aws) to an Amazon S3 frequent access storage class.
3. Deploy 100 x [Commvault Cloud Access Node ARM BYOL](https://aws.amazon.com/marketplace/pp/prodview-usqf7gn3ipqke?sr=0-2&ref_=beagle&applicationId=AWSMPContessa) using Amazon CloudFormation and optionally upgrade them using a push install from previously installed Commvault all-in-one solution (step 1).
4. Configure additional settings to permit massively parallel scheduling of recovery across the 100 Access Nodes.
5. Run a massively parallel restore.
6. Cleanup (terminate) your 100 x [Commvault Cloud Access Node ARM BYOL](https://aws.amazon.com/marketplace/pp/prodview-usqf7gn3ipqke?sr=0-2&ref_=beagle&applicationId=AWSMPContessa) instances using Amazon CloudFormation.
7. Cleanup (delete) your 100 Commvault Cloud Access Nodes from Commvault Backup & Recovery client registry.

100 instances here are used as an example only to demonstrate the massively parallel nature of __Commvault Backup & Recovery__, Amazon S3, and Amazon EC2 compute. Commvault recommends performing regular testing and GameDays in your IT, Security, and Application teams to find the right mix of recovery speed (throughput) and recovery cost.

Note: The [Commvault Backup & Recovery BYOL](https://aws.amazon.com/marketplace/pp/prodview-ecysdywnipxv6?sr=0-3&ref_=beagle&applicationId=AWSMPContessa) product comes with a free 30-day trial so you can try this out yourself. You will incur additional costs for the AWS services you utilize during your test. Consult the AWS pricing pages for more details.

## ⏩ Recovery results

Commvault lab testing was performed using the following setup:
- 1 x Commvault Backup & Recovery / Amazon EC2 instance (M6a.2xlage) (8 vCPU, 32GiB RAM)
- 100 x Commvault Cloud Access Nodes / Amazon EC2 C6g.large instance (2 vCPU, 4GiB) **AWS Graviton**
- 100 x Amazon EC2 test instances totalling 1TiB of randomly generated data.

Restore time: **9 mins**

## 🛠️ Setup - Step 1 - Deploy Commvault from the AWS Marketplace

1. Login to [AWS Console](https://aws.amazon.com/console/) as a user that can deploy new Amazon EC2, Amazon S3. and AWS IAM resources using Amazon CloudFormation.
2. Open new browser tab to [AWS Marketplace](https://aws.amazon.com/marketplace) and search for ```Commvault```.
3. Click [Commvault Backup & Recovery BYOL](https://aws.amazon.com/marketplace/pp/prodview-ecysdywnipxv6?sr=0-3&ref_=beagle&applicationId=AWSMPContessa).
4. Click **Continue to Subscribe** button (top-right).
5. Click **Continue to Configuration** button (top-right).
6. Select **CloudFormation Template** Fulfilment Option.
7. Select **Commvault Backup & Recovery: BYOL Deployment CloudFormation template** (default).
8. Select latest Software version (I.E., Platform Release 2023e).
9. Select your **Region**.
10. Click **Continue to Launch** button.
11. Select **Launch CloudFormation** action.
12. Click **Launch** button.
13. Click **Next** on Step 1 – Create Stack.
14. Enter a **Stack Name**.
15. Leave EC2 Instance Type as **m6a.2xlarge** (Commvault recommended default).
16. Select a **Key Pair**.
17. Enter an **Administrator email** for Amazon CloudWatch alarms/alerts.
18. Select an existing **Amazon VPC** ID.
19. Select a **Public Subnet** ID (if accessing via the Internet), or a subnet you can access via AWS Direct Connect or pre-setup bastion host (Consisider using Amazon EC2 Instance Connect for secure access without a need for public IP).
20. Select **true** if you want a permanent (static) Elastic IP for the all-in-one CommServe (optional).
21. Provide the IP Address or Subnet of your **Authorized Admin Subnet administrative hosts** allowed to login (Remote Desktop Protocol) into the Microsoft Windows-based Commvault Backup & Recovery instance.
22. Select all Protected Subnets that will be able to speak securely with the CommServe via encrypted AES-256 sessions over port 8400-8403.
23. Select true if you would like to deploy a S3 VPC Endpoint (Gateway) set to false if you already have one.
24. Click **Next** button.
25. Click **Next** button.
26. Select the **I acknowledge that AWS CloudFormation might create IAM resources with custom names.** checkbox.
27. Click **Submit** button.

WARNING: If you also have a role called ‘CommvaultBackupAndRecovery’ the stack will fail to deploy.

## :balance_scale: License

This e

## :handshake: Contributing

Although we're extremely excited to receive contributions from the community, we're still working on the best mechanism to take in examples from external sources. Please bear with us in the short-term if pull requests take longer than expected or are closed.
Please read our [contributing guidelines](https://github.com/mericson-cv/aws-massively-parallel-recovery-solution/master/CONTRIBUTING.md)
if you'd like to open an issue or submit a pull request.
