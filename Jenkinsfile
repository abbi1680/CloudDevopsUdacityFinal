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
        stage('HadoLint - Docker') {
          steps {
            echo 'empty for the moment'
          }
        }
      }
    }
  }
}
