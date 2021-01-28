aws cloudformation create-stack \
--stack-name red-team-longterm  \
--template-body file://longterm_servers.yml \
--parameters file://long_term_parameters.json \
--region=us-west-2 \
--on-failure DELETE \
--capabilities CAPABILITY_IAM
