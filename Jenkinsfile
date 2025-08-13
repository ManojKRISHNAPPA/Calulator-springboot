pipeline{
    agent any

    tools {
        jdk 'java-17'
        maven 'Maven'
    }

    environment {
        MAVEN_OPTS = '-Dnet.bytebuddy.experimental=true -XX:+EnableDynamicAgentLoading'
    }

    stages{
        stage('Git-Chekout'){
            steps{
                git branch: 'main', url: 'https://github.com/ManojKRISHNAPPA/Calulator-springboot.git'
            }
        }

        stage('Compile'){
            steps{
                sh 'mvn clean compile'
            }
        }

        stage('Test'){
            steps{
                sh 'mvn test'
            }
            post{
                always {
                    junit allowEmptyResults: true, testResults: '**/target/surefire-reports/*.xml'
                }
            }

        }

        stage('Build'){
            steps{
                sh 'mvn clean package -DskipTests=true'
            }
        }

    }
}