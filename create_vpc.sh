aws cloudformation create-stack \
--stack-name red-team  \
--template-body file://red_team_vpc.yml \
--parameters file://red_team_vpc_parameters.json \
--region=us-west-2 \
--on-failure DELETE \
--capabilities CAPABILITY_IAM
