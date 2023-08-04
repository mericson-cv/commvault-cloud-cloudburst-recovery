# Commvault Backup & Recovery - Massively Parallel Recovery Solution

Example Infrastructure as Code (IaC) solution using [AWS CloudFormation](https://aws.amazon.com/cloudformation/), [HashiCorp Terraform](https://www.terraform.io/) to deploy on-demand and Spot Amazon EC2 instances to perform a massively parallel recovery using [Commvault Backup & Recovery](https://www.commvault.com/platform/products/backup-and-recovery).

## :books: Background

[Commvault Backup & Recovery](https://www.commvault.com/aws) is the industry leading data protection and cyber-resilience solution for protecting AWS services, SaaS, and other hybrid workloads. You can use Commvault Backup & Recovery to secure, defend, and recover your business applications and data (learn more at [www.commvault.com](https://www.commvault.com).

This example solution show-cases the elasticity of Amazon EC2, the scalability of Amazon S3, and the power of the Commvault Backup & Recovery data platform to achieve a massivelly parallel restore with on-demand ephemeral resources deployed using Infrastructure as Code.

A part of any modern data management plan includes an understanding of your business _recovery time objectives_ and in extreme circumstances (i.e., where multiple applications are affected), the elastic nature of AWS compute allows a rapid and **cost effective** rapid recovery solution for many systems in parallel.

![Commvault Massively Parallel Restore - Reference Architecture](https://github.com/mericson-cv/aws-massively-parallel-recovery-solution/blob/main/commvault-massively-parallel-recovery-solution.png)

## :hammer_and_wrench: Setup

At a high-level the process for setup and execution this solution (depicted above) is as follows:
1. Deploy [Commvault Backup & Recovery BYOL](https://aws.amazon.com/marketplace/pp/prodview-ecysdywnipxv6?sr=0-3&ref_=beagle&applicationId=AWSMPContessa) from the [AWS Marketplace](https://aws.amazon.com/marketplace/seller-profile?id=88cecb14-a8b2-49bd-ba1f-58be76108f48) using AWS CloudFormation.
2. Review the ```CommvaultBackupAndRecovery``` AWS IAM role and policies that allow Commavult to backup and recovery your AWS workloads.
3. Complete the [Core Setup Wizard](https://documentation.commvault.com/2023e/essential/86625_quick_start_guide.html#step-3-complete-core-setup-wizard) and run a backup of your EC2 instances and/or other [supported workloads](https://www.commvault.com/supported-technologies/amazon/aws) to Amazon S3.
4. Deploy 100 x [Commvault Cloud Access Node ARM BYOL](https://aws.amazon.com/marketplace/pp/prodview-usqf7gn3ipqke?sr=0-2&ref_=beagle&applicationId=AWSMPContessa) with [CloudFormation template](https://github.com/mericson-cv/aws-massively-parallel-recovery-solution/tree/main/cloudformation) and configure.
5. Run a massively parallel restore.

:bulb: Tip: There are HashiCorp Terraform examples in the [terraform folder](https://github.com/mericson-cv/aws-massively-parallel-recovery-solution/tree/main/terraform) to quickly deploy on-demand or [Amazon EC2 Spot Instances](https://aws.amazon.com/ec2/spot/), complete with _random data_ generation on first boot. 

_100 instances are used only as an example to demonstrate the massively parallel nature of __Commvault Backup & Recovery__, Amazon S3, and Amazon EC2 compute. Commvault recommends performing regular testing and [GameDays](https://aws.amazon.com/gameday/) in your IT, Security, and Application teams to find the right mix of recovery speed (throughput) and overall recovery cost_. 

The key **benefit** of this solution is that the recovery resources are __ephemeral__ and may be destroyed immediately after the restore is complete.

💲Note: The [Commvault Backup & Recovery BYOL](https://aws.amazon.com/marketplace/pp/prodview-ecysdywnipxv6?sr=0-3&ref_=beagle&applicationId=AWSMPContessa) product comes with a free 30-day trial so you can try this out yourself. You will incur additional costs for the AWS services you utilize during your test. Consult the AWS pricing pages for more details.

## 🛠️ Setup - Step 1 - Deploy Commvault Backup & Recovery from the AWS Marketplace

This step deploys Commvault Backup & Recovery as a single Amazon EC2 instance running Microsoft Windows. If you already have a Commvault Backup & Recovery deployment, you may skip this step.

1. Login to [AWS Console](https://aws.amazon.com/console/) as a user that can deploy new Amazon EC2, Amazon S3. and AWS IAM resources using Amazon CloudFormation.
2. Open new browser tab to [AWS Marketplace](https://aws.amazon.com/marketplace) and search for ```Commvault```.
3. Click [Commvault Backup & Recovery BYOL](https://aws.amazon.com/marketplace/pp/prodview-ecysdywnipxv6?sr=0-3&ref_=beagle&applicationId=AWSMPContessa).
4. Select *CloudFormation Template* Fulfilment Option.
5. Select the *I acknowledge that AWS CloudFormation might create IAM resources with custom names.* checkbox.
6. Click *Submit* to deploy.

## 🛠️ Setup - Step 2 - Review the created AWS IAM role and policies that allow Commavult to backup and recovery your AWS workloads.

Commvault will create a single AWS IAM Role called `CommvaultBackupAndRecovery`.

Detailed information of the AWS IAM Policies required by Commvault (per AWS workload) may be viewed [here](https://documentation.commvault.com/2023e/essential/101442_requirements_and_usage_for_aws_iam_policies_and_permissions.html#iam-policies).

## 🛠️ Setup - Step 3 - Complete the Core Setup Wizard and run a backup.

### Creating a Commvault admin account
1. Obtain your ```Administrator``` password for your newly created ```Commvault Backup & Recovery``` instance.
2. Login using Remote Desktop Protocol (RDP) - Commvault recommends using [Amazon EC2 Instance Connect](https://aws.amazon.com/about-aws/whats-new/2023/06/amazon-ec2-instance-connect-ssh-rdp-public-ip-address/) for secure access to your Commvault instance _without_ the need to expose public IP addresses, or manage __bastion hosts__.
3. Wait for the ```******* Starting Commserve image customization ********``` powershell bootstrapper script to complete. This script runs only once, at first boot to configure the Commvault software and trial license.

💡 **Tip**: *Be patient*, remember that each of the Amazon EBS volumes on the host is being provisioned from Amazon EBS snapshots that are stored in Amazon S3.

A browser will open when complete advanced, proceed to localhost (unsafe)
[https://localhost/adminconsole](https://localhost/adminconsole)

4.	Provide the **Email address(( that will be associated with the Commvault ‘admin’ built-in account ([break glass account](https://docs.aws.amazon.com/whitepapers/latest/organizing-your-aws-environment/break-glass-access.html)).
5.	Provide the **Password** that will be associated with the Commvault ‘admin’ built-in account.
6.	Click **Create account** button
7.	You will be greeted with Command Center login screen. Login with newly provide admin and password.
8.	Click **OK** to accept the License and Registration warning.

:warning: Warning: If you are using a trial license the ```Cloud Storage``` license will be constrained to a maximum of ten (10) concurrent MediaAgents during the restore. If you have a paid Commvault license, you can [submit a request](https://ma.commvault.com/Support/ProductRegistration) to extend your ```Cloud Storage``` license to match your required parallism (i.e., the total number of MediaAGents you will have active in your Commvault environment).

### Completing Commvault Core Setup
1. Click Let’s get started
2. Click Cloud in the Add storage page.
3. Provide a Cloud library Name (i.e., Amazon S3-IA (us-east-1))
4. Select Amazon S3 as the Cloud storage Type.
5. Leave MediaAgent with the configured (default) MediaAgent (the CommServe).
6. Set the Service host to s3.us-east-1.amazonaws.com (your Region may differ).
7. Select IAM role for the Credentials
8. Enter the bucket name created in your AWS CloudFormation deployment

💡 Hint: You can find the bucket name in the AWS CloudFormation Console, in your stack, on the Outputs tab, as CvltCloudLibraryBucketName

9. Select the Storage class, the default S3 Standard-Infrequent Access (S3 Standard-IA) is the recommended Storage Class for Backup data.
10. Leave Use deduplication enabled.
11. Enter the Deduplication DB location, use the volume pre-setup, pre-formatted with correct block-size (i.e., H:\)

```Example: Enter H:\Amazon S3-IA – DDB```

12. Click Save on the Create server backup plan page to accept defaults for server plans.

⚠️ If you also have a role called ‘CommvaultBackupAndRecovery’ the stack will fail to deploy.

### (Optional) Upgrade Commvault Backup & Recovery to latest Maintenance Release
1. Download the latest Full Install Image to the CommServe
2. Execute Setup.exe as Administrator
3. Select I Agree checkbox, click Next button
4. Select Install packages on this computer, click Next button
5. Select Upgrade Feature Release, click Next button
6. Select Perform Full Database Maintenance, click Next button, click Next button (again)
7. The machine needs to be restarted, click Reboot Now
8. Login again
9. Install will start automatically
10. Select Resume install, click Next button

## ⏩ Recovery results

Commvault lab testing was performed using the following setup:
- 1 x Commvault Backup & Recovery / Amazon EC2 instance ([M6a.2xlage](https://aws.amazon.com/ec2/instance-types/m6a/)) (8 vCPU, 32GiB RAM)
- 100 x Commvault Cloud Access Nodes / Amazon EC2 instances ([C6g.large](https://aws.amazon.com/ec2/instance-types/c6g/) (2 vCPU, 4GiB) **AWS Graviton** ⭐⭐⭐
- 100 x Amazon EC2 test instances totalling 1TiB of randomly generated data.

![Test Result](commvault-massively-parallel-recovery-result.png)

## Cleanup
   
Don't forget to cleanup (terminate) your 100 x [Commvault Cloud Access Node ARM BYOL](https://aws.amazon.com/marketplace/pp/prodview-usqf7gn3ipqke?sr=0-2&ref_=beagle&applicationId=AWSMPContessa) instances using Amazon CloudFormation.

Once terminated you can remove the MediaAgents from your Commvault Backup & Recovery system using the supplied [powershell scripts](https://github.com/mericson-cv/aws-massively-parallel-recovery-solution/tree/main/powershell).

   
## :balance_scale: License

This code is offered and licensed under the [Apache 2.0](https://github.com/mericson-cv/aws-massively-parallel-recovery-solution/blob/main/LICENSE.md) license.

## ❓Getting Support

If you need assistance with your Commvault Backup & Recovery software you can Join in at the [commuunity](https://community.commvault.com), Check the [docs](https://docs.commvault.com), or [Log a support call](https://ma.commvault.com).

## :handshake: Contributing

Although we're extremely excited to receive contributions from the community, we're still working on the best mechanism to take in examples from external sources. Please bear with us in the short-term if pull requests take longer than expected or are closed.
Please read our [contributing guidelines](https://github.com/mericson-cv/aws-massively-parallel-recovery-solution/master/CONTRIBUTING.md)
if you'd like to open an issue or submit a pull request.
