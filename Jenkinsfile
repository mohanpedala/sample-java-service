pipeline {
    agent {
      kubernetes {
        label 'ci-app'
        idleMinutes 5
        yamlFile './pipeline/build-pod.yaml'
        defaultContainer 'maven'      
      }
    }
    stages {
      stage('Build maven package') {
        steps {
          sh "mvn clean package"
        }
      }
      stage('Build Docker Image') {
        steps {
          container('docker') {
            sh "docker build -t phaneindra/sample-java-app:v3 ."
            sh "docker push phaneindra/sample-java-app:v3"
          }
        }
      }
    }
}