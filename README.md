![Commvault Backup & Recovery](https://media.licdn.com/dms/image/C4E0BAQHatJ6EtVFZlQ/company-logo_200_200/0/1655393666027?e=1698883200&v=beta&t=WLBL8ERyPVlKWEgjHC2qIPZlsdJejA_bP1K6z12P3m4)

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

## :balance_scale: License

This e

## :handshake: Contributing

Although we're extremely excited to receive contributions from the community, we're still working on the best mechanism to take in examples from external sources. Please bear with us in the short-term if pull requests take longer than expected or are closed.
Please read our [contributing guidelines](https://github.com/mericson-cv/aws-massively-parallel-recovery-solution/master/CONTRIBUTING.md)
if you'd like to open an issue or submit a pull request.
