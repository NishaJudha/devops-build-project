pipeline {
    agent any

    environment {
        DEV_IMAGE = "nishajudha/dev-project"
    }

    stages {

        stage('Check Branch') {
            steps {
                sh '''
                echo "BRANCH_NAME=$BRANCH_NAME"
                git branch
                '''
            }
        }

        stage('Build') {
            steps {
                sh '''
                chmod +x build.sh deploy.sh
                ./build.sh
                '''
            }
        }

        stage('Push Dev') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhub-creds',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                    )
                ]) {
                    sh '''
                    echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin

                    docker tag react-app:latest ${DEV_IMAGE}:latest

                    docker push ${DEV_IMAGE}:latest

                    docker logout
                    '''
                }
            }
        }

        stage('Deploy') {
            steps {
                sh './deploy.sh'
            }
        }
    }

    post {
        success {
            echo 'Pipeline executed successfully!'
        }

        failure {
            echo 'Pipeline failed. Check console logs.'
        }
    }
}
