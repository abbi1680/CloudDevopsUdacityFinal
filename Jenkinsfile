pipeline {
  agent any
  stages {
    stage('env configuration') {
      steps {
        sh 'make setup;make install'
        sh ''' pip3 install awscli --upgrade --user
'''
      }
    }
    stage('Linting') {
      parallel {
        stage('Lint HTML') {
          steps {
            sh ' tidy -q -e templates/*.html'
          }
        }
        stage('Lint Python') {
          steps {
            sh 'make pylint'
          }
        }
        stage('Lint DockerFile') {
          steps {
            sh 'make hadolint'
          }
        }
      }
    }
    stage('Build Container') {
      steps {
        echo 'building container'
        sh '''version=$(cut -d= -f2 app_version.txt );docker build --tag=maxblogapi:$version .
'''
        sh '''docker image ls
'''
      }
    }
    stage('Docker Push') {
      steps {
        echo 'pushing the image to registry'
        sh '''version=$(cut -d= -f2 app_version.txt );echo "tag the newly created image to the repo";

docker tag maxblogapi:$version 175374130779.dkr.ecr.us-east-2.amazonaws.com/maxblog-repo:$version'''
        sh 'version=$(cut -d= -f2 app_version.txt );$(aws ecr get-login --no-include-email --region us-east-2);docker push 175374130779.dkr.ecr.us-east-2.amazonaws.com/maxblog-repo:$version'
      }
    }
    stage('check Active Env') {
      steps {
        echo 'check whether Blue or Green Environment is acitve'
        sh 'aws eks --region us-east-2 update-kubeconfig --name prodCluster; kubectl get svc'
        sh '''isblue=$(kubectl get deployments | grep maxblog |grep blue|wc -l);
if [ $isblue -eq "1" ]
then
   echo "green">inactiveEnv.txt;
  echo "blue">activeEnv.txt;
else
   echo "blue">inactiveEnv.txt;	
   echo "green">activeEnv.txt;
fi'''
      }
    }
    stage('Deploy') {
      steps {
        echo 'deploying the application'
        sh 'version=$(cut -d= -f2 app_version.txt );DEPLOYMENT=$(cat inactiveEnv.txt) IMAGE_TAG=$version envsubst < aws/AppsDeploymentsStrategy/deployment.yml | kubectl apply -f -'
      }
    }
    stage('Waiting for completion and running a test endpoint') {
      steps {
        echo 'create a new service for test purposes if needed'
        sh 'DEPLOYMENT=$(cat inactiveEnv.txt) envsubst < aws/AppsDeploymentsStrategy/testEndpoint.yaml | kubectl apply -f -'
        sh '''DEPLOYMENTNAME=maxblog-deployment-$(cat inactiveEnv.txt);
READY=$(kubectl get deploy $DEPLOYMENTNAME -o json | jq \'.status.conditions[] | select(.reason == "MinimumReplicasAvailable") | .status\' | tr -d \'"\')
while [[ "$READY" != "True" ]]; do
    READY=$(kubectl get deploy $DEPLOYMENTNAME -o json | jq \'.status.conditions[] | select(.reason == "MinimumReplicasAvailable") | .status\' | tr -d \'"\')
    sleep 5
done'''
      }
    }
    stage('Switching Services ') {
      steps {
        echo 'Switch the elb to the newly deployed app'
        sh 'DEPLOYMENT=$(cat inactiveEnv.txt) envsubst < aws/AppsDeploymentsStrategy/publicEndpoint.yaml | kubectl apply -f -'
      }
    }
    stage('Test Prod OK') {
      steps {
        echo 'Test the new Pods are OK and confirm the delete of the app'
      }
    }
    stage('Delete old App and Test Service') {
      steps {
        echo 'delete old app as the new is active'
        sh '#kubectl delete service  maxblogapi-service-test;#kubectl delete deployment maxblog-deployment-$(cat activeEnv)'
      }
    }
  }
}