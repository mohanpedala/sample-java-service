pipeline {
    environment {
      imagename = "phaneindra/sample-java-app"
      registryCredential = 'docker'
      dockerImage = ''
    }
    agent {
      kubernetes {
        inheritFrom 'ci-app'
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
      stage('Build docker image') {
        steps {
          container('docker') {
            script {
              sh 'echo "starting docker build"' 
              dockerImage = docker.build imagename
              sh 'echo "Image build completed"'
            }
          }
        }
      }
      stage('Deploy Image') {
        steps {
          container('docker') {
            script {
              docker.withRegistry( '', registryCredential ) {
                dockerImage.push("$BUILD_NUMBER")
                dockerImage.push('latest')
              }
            }            
          }
        }
      }
    }
}
