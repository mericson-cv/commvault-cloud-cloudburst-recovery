![Commvault Backup & Recovery](https://www.commvault.com/wp-content/uploads/2020/06/vc-june-fi.png)

# Commvault Backup & Recovery - Massively Parallel Recovery Example

Example Infrastructure as Code (IaC) solution using Amazon CloudFormation, HashiCorp Terraform to deploy on-demand Amazon EC2 instances to perform a massively parallel recovery using Commvault Backup & Recovery.

## :books: Background

[Commvault Backup & Recovery](https://www.commvault.com/aws) is the industry leading data protection and cyber-resilience solution from AWS services, SaaS, and hybrid workloads. You can use Commvault Backup & Recovery to secure, defend, and recover your business applications and data.

This example solution show-cases the elasticity of Amazon EC2, the scalability of Amazon S3, and the power of the Commvault Backup & Recovery data platform to achieve a massivelly parallel restore with on-demand ephemeral resources deployed using Infrastructure as Code.

## :hammer_and_wrench: Setup

At a high-level the process for using this example is:
1. Setup a Commvault CommServe (or use and existing Commvault installation).
2. Backup the Amazon EC2 workloads (and any of the other protected workloads in your environment) to Amazon S3 frequent access storage class.
3. Deploy 
