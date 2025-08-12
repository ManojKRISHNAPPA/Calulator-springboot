pipeline {
    agent any

    tools {
        jdk 'java-17'
        maven 'maven'
    }

    environment {
        MAVEN_OPTS = '-Dnet.bytebuddy.experimental=true -XX:+EnableDynamicAgentLoading'
    }

    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/ManojKRISHNAPPA/Calulator-springboot.git'
            }
        }

        stage('Compile') {
            steps {
                sh 'mvn compile'
            }
        }
        stage('Unit Test') {
            steps {
                sh 'mvn test'
            }
            post {
                always {
                    junit allowEmptyResults: true, testResults: '**/target/surefire-reports/*.xml'
                }
            }
        }


        stage('Build') {
            steps {
                sh 'mvn clean package -DskipTests=true'
            }
        }

        stage('Generate JaCoCo Report') {
            steps {
                sh 'mvn jacoco:report'
            }
        }

        stage('Publish Code Coverage') {
            steps {
                jacoco(
                    execPattern: '**/target/jacoco.exec',
                    classPattern: '**/target/classes',
                    sourcePattern: '**/src/main/java',
                    inclusionPattern: '**/*.class'
                )
            }
        }
        stage('SonarQube Analysis') {
            steps {
                script {
                    withSonarQubeEnv('SonarQube') {
                        sh """
                            mvn sonar:sonar \
                            -Dsonar.projectKey=devsecops \
                            -Dsonar.host.url=http://3.92.231.206:9000 \
                            -Dsonar.login=441102fab89b2aa1803e8e901b6bb7d49f12be48
                        """
                    }
                }
            }
        }

        // stage('Mutation Tests - PIT') {
        //     steps {
        //         script {
        //             try {
        //                 sh "mvn org.pitest:pitest-maven:mutationCoverage"
        //             } catch (Exception e) {
        //                 echo "PIT mutation testing failed: ${e.getMessage()}"
        //                 currentBuild.result = 'UNSTABLE'
        //             }
        //         }
        //     }
        //     post {
        //         always {
        //             // Publish PIT mutation testing results if they exist
        //             script {
        //                 if (fileExists('target/pit-reports')) {
        //                     pitmutation mutationStatsFile: 'target/pit-reports/**/mutations.xml'
        //                 } else {
        //                     echo 'No PIT reports found to publish'
        //                 }
        //             }
        //         }
        //     }
        // }
        
    }

    post {
        always {
            // Clean up workspace
            cleanWs()
        }
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
        unstable {
            echo 'Pipeline completed with warnings!'
        }
    }
}