pipeline {
    agent any

    stages {
        stage('Stop the Existing Container') {
            steps {
                catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                    sh 'docker container stop node-api-server'
                }
            }
        }
        stage('Deploy the New Version') {
            steps {
                dir('api-server') {
                    sh 'docker build . -t api-server'
                }

                sh 'docker run --rm -d -p 3000:3000 --name node-api-server api-server'
            }
        }
    }
}