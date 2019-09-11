aws eks create-cluster --name prodCluster \
--kubernetes-version 1.14 \
--role-arn arn:aws:iam::175374130779:role/finalProject-ServiceRole-PQ69FVXNQI1B \
--resources-vpc-config subnetIds=subnet-08ee958670ee07e6e,subnet-02afc1bd0de45ceca,subnet-0fd2cc6e687cd49ba,subnet-0461fa099c79b5119,securityGroupIds=sg-094aa15cb43736367 \
--region us-east-2
