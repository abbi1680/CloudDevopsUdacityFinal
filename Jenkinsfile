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
            sh 'make setup; make pylint'
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