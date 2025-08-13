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

        stage('Publish code coverage report'){
            steps{
                sh 'mvn jacoco:report'
            }
            post {
                always {
                    jacoco execPattern: '**/target/jacoco.exec', classPattern: '**/target/classes', sourcePattern: '**/src/main/java', exclusionPattern: '', changeBuildStatus: true
                }
            }
        }

        stage('SonarQube - SAST'){
            steps{
                sh """
                    mvn sonar:sonar \
                    -Dsonar.projectKey=Devsecops-calculator \
                    -Dsonar.host.url=http://54.197.73.230:9000 \
                    -Dsonar.login=470025acd8fcee5a2ff55d48c93717fbc3d44f95
                """
            }
        }

    }
}