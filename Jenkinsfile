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
        sh 'kubectl version;kubectl get deployments | grep maxblogapi |wc -l'
      }
    }
    stage('Deploy') {
      steps {
        echo 'deploying the application'
        sh '''version=$(cut -d= -f2 app_version.txt );DEPLOYMENT=blue IMAGE_TAG=$version 
envsubst < aws/AppsDeploymentsStrategy/deployment.yml | kubectl apply -f -'''
        sh '''version=$(cut -d= -f2 app_version.txt );DEPLOYMENT=blue IMAGE_TAG=$version 
envsubst < aws/AppsDeploymentsStrategy/deployment.yml | cat'''
      }
    }
    stage('Test deployed App') {
      steps {
        echo 'deployement'
      }
    }
    stage('Switching Services ') {
      steps {
        echo 'Test the application'
      }
    }
    stage('Test Prod OK') {
      steps {
        echo 'Test the new Pods are OK'
      }
    }
    stage('Delete old App') {
      steps {
        echo 'delete old app as the new is active'
      }
    }
  }
}