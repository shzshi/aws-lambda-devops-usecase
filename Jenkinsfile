pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION="us-east-1"
    }

    stages {
        
        stage ('Deploy to DEV') {

            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'dev-serverless', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                    sh "serverless deploy --stage dev"
                }
            }
        }

        stage ('System Test on Dev') {
             
             steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'dev-serverless', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                    sh ''' 
                       export TASKS_ENDPOINT=http://localhost:3000
                       serverless invoke test
                    '''
                }
             }
        }

        stage ('Deploy to SIT') {

            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'sit-serverless', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                    sh "serverless deploy --stage sit"
                }
            }
        }

        stage ('System Test on SIT') {
             
             steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'sit-serverless', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                    sh ''' 
                       export TASKS_ENDPOINT=ax1hlqv0vl.execute-api.us-east-1.amazonaws.com/sit
                       serverless invoke test
                    '''
                }
             }
        }

        stage('Promotion') {
            steps {
                timeout(time: 1, unit:'DAYS') {
                    input 'Deploy to Production?'
                }
            }
        }
        
        stage ('Deploy to PROD') {

            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'prod-serverless', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                    sh "serverless deploy --stage prod"
                }
            }
        }

        stage ('System Test on PROD') {
             
             steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'prod-serverless', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                    sh ''' 
                       export TASKS_ENDPOINT=valdnbrq3a.execute-api.us-east-1.amazonaws.com/prod
                       serverless invoke test
                    '''
                }
             }
        }

    }
}