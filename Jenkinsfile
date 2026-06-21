pipeline {
    agent any

    environment {
        DEV_IMAGE  = "nishajudha/dev-project"
        PROD_IMAGE = "nishajudha/prod-project"
    }

    stages {

        stage('Build') {
            steps {
                sh '''
                chmod +x build.sh deploy.sh
                ./build.sh
                '''
            }
        }

        stage('Push Dev') {
            when {
                branch 'dev'
            }
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhub-creds',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                    )
                ]) {
                    sh '''
                    echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                    docker tag react-app:latest $DEV_IMAGE:latest
                    docker push $DEV_IMAGE:latest
                    docker logout
                    '''
                }
            }
        }

        stage('Push Prod') {
            when {
                branch 'master'
            }
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhub-creds',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                    )
                ]) {
                    sh '''
                    echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                    docker tag react-app:latest $PROD_IMAGE:latest
                    docker push $PROD_IMAGE:latest
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
