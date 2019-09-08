pipeline {
  agent any
  stages {
    stage('env configuration') {
      steps {
        sh 'make setup;make install'
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
        sh '''docker build --tag=maxblogapi .
'''
        sh '''docker image ls
'''
      }
    }
    stage('Docker Push') {
      steps {
        echo 'pushing the image to registry'
        sh '''echo "tag the newly created image to the repo";

docker tag maxblogapi:latest 175374130779.dkr.ecr.us-east-2.amazonaws.com/maxblog-repo:latest'''
        script{        
		docker.withRegistry('https://175374130779.dkr.ecr.us-east-2.amazonaws.com', 'AWS-Final') {
    		docker.image('demo').push('latest')
		}
	}
      }
    }
    stage(' registry check') {
      steps {
        echo 'check the lastest image'
      }
    }
    stage('PreDeploy Check') {
      steps {
        echo 'check if kube is here'
      }
    }
    stage('Deploy') {
      steps {
        echo 'deployement'
      }
    }
    stage('Test app') {
      steps {
        echo 'Test the application'
      }
    }
  }
}
