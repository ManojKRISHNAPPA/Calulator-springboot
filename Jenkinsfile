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

        // stage('SonarQube - SAST'){
        //     steps{
        //         sh """
        //             mvn sonar:sonar \
        //             -Dsonar.projectKey=Devsecops-calculator \
        //             -Dsonar.host.url=http://54.197.73.230:9000 \
        //             -Dsonar.login=470025acd8fcee5a2ff55d48c93717fbc3d44f95
        //         """
        //     }
        // }

        stage('build && SonarQube analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    // Optionally use a Maven environment you've configured already
        
                        sh 'mvn clean package org.sonarsource.scanner.maven:sonar-maven-plugin:sonar'
                    
                }
            }
        }
        stage("Quality Gate") {
            steps {
                timeout(time: 2, unit: 'MINUTES') {
                    // Parameter indicates whether to set pipeline to UNSTABLE if Quality Gate fails
                    // true = set pipeline to UNSTABLE, false = don't
                    waitForQualityGate abortPipeline: true
                }
            }
        }        

    }
}