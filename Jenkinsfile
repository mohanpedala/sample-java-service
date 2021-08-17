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
      stage('Building image') {
        steps{
          script {
            dockerImage = docker.build(imagename)
          }
        }
      }
      stage('Deploy Image') {
        steps{
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
