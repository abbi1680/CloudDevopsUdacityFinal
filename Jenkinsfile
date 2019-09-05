pipeline {
  agent any
  stages {
    stage('Linting') {
      parallel {
        stage('Lint HTML') {
          steps {
            sh ' tidy -q -e templates/*.html'
          }
        }
        stage('Lint Python') {
          steps {
            sh 'pylint --disable=R,C,W1203 app.py'
          }
        }
      }
    }
    stage('Build Container') {
      steps {
        echo 'building container'
      }
    }
    stage('Docker Push') {
      steps {
        echo 'pushing the image to registry'
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