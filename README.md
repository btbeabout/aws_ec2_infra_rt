# aws_ec2_infra_rt
Simple repo to store some scripts for automating the deployment of an Amazon VPC with two subnets and three hosts with CloudFormation.

The idea behind this repo is to set out some simple, editable files that can be used with the awscli, CloudFormation, and S3 to make it easier to deploy (and re-deploy) a cloud-hosted infrastructure in a semi=piecemeal fashion.

The s3_upload.sh script creates an S3 bucket (leveraging a Bash variable named my_aws_bucket which needs to be set prior to use), configures the bucket's privacy settings as to not expose the contents publicly, then uploads all files in the S3/Longterm directory (currently a single .htaccess file). This is in anticipation of using these files when provisioning the following VMs.

The create_vpc.sh script contains a single awscli command to use the red_team_vpc.yml and red_team_vpc_parameters.json files to spin up a VPC within EC2 containing a single public subnet, a single private subnet, an IAM profile for interacting with S3, and a re-usable Bastion host for accessing VMs within the private subnet, but isn't intended to receive redirection, beaconing, or payload traffic.
* Depends on the existence of red_team_vpc.yml and red_team_vpc_parameters.json
* Since the Bastion host is only being used as jumpbox, it does not contain any data or tools but can be used as a bridge for SSH tunneling.

The create_longterm_servers.sh script also contains a single awscli command that spins up two additional VMs in the VPC, one in the public subnet to serve as a redirector, and the other in the private subnet to serve as a C2 team server.
* Depends on the existence of longterm_servers.yml and long_term_parameters.json (which isn't included in this repo, but follows the same logic as red_team_vpc_parameters.json).
* Uses the IAM role configured by create_vpc.sh to pull down the .htaccess file from S3 to the Redirector, which also configures Apache2 to use mod_rewrite redirection.
* Downloads and configures Mythic C2 on the private C2 server with default settings.
