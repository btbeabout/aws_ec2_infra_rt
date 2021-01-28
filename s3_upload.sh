#/bin/bash

# Create bucket and set privacy settings
aws s3api create-bucket --acl private --bucket ${my_aws_bucket} --create-bucket-configuration LocationConstraint=us-west-2
aws s3api put-public-access-block --bucket ${my_aws_bucket} --public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true"

# Copy local files to S3
aws s3 cp ./S3/Longterm s3://${my_aws_bucket}/Longterm --recursive
