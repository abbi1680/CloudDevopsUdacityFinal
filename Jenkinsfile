pipeline {
  agent any
  stages {
    stage('Lint HTML') {
      parallel {
        stage('first test') {
          steps {
            sh ' tidy -q -e templates/*.html'
          }
        }
        stage('Lint PY') {
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