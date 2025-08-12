pipeline {
    agent any

    tools {
        maven 'maven'
        jdk 'java-11'
    }

    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'devsecops', url: 'https://github.com/ManojKRISHNAPPA/Project-movie-app.git'
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
        }

        stage('Build') {
            steps {
                sh 'mvn clean package'
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
        stage('Mutation Tests - PIT') {
          steps {
            sh "mvn org.pitest:pitest-maven:mutationCoverage"
          }
          post {
            always {
              // Target server module specifically
              pitmutation mutationStatsFile: 'server/target/pit-reports/**/mutations.xml'
            }
          }
        }
    }

    post {
        always {
            junit '**/target/surefire-reports/*.xml'
        }
    }
}