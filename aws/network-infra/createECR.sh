# repository creation on amazon ecr

aws ecr create-repository --repository-name maxblog-repo --region us-east-2

# tag the newly created image to the repo

docker tag maxblogapi:latest 175374130779.dkr.ecr.us-east-2.amazonaws.com/maxblog-repo:latest


# pushing the docker image to amazon ecr

aws ecr get-login --no-include-email --region us-east-2 | bash

docker push 175374130779.dkr.ecr.us-east-2.amazonaws.com/maxblog-repo:latest


# optianal remove the ecr repo to avoid charges

#aws ecr delete-repository --repository-name maxblog-repo --region us-east-2 --force
