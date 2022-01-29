pipeline {
    agent none
    stages {
        stage('Build and Test') {
            agent {
                label 'jupyter'
            }
            stages{
                stage('Build') {
                    steps {
                        sh 'podman build -t geog132 --pull  --no-cache .'
                     }
                }
                stage('Test') {
                    steps {
                        sh 'podman run -it --rm localhost/geog132 python -c "from osgeo import gdal; import matplotlib; import numpy; import pandas"'
                        sh 'podman run -it --rm localhost/geog132 R -e "library(\"tidyverse\");library(\"lme4\");library(\"rstan\");library(\"brms\")"'
                    }
                
                }
            }
        }
    }
    post {
        success {
            slackSend(channel: '#infrastructure-build', username: 'jenkins', message: "Build ${env.JOB_NAME} ${env.BUILD_NUMBER} just finished successfull! (<${env.BUILD_URL}|Details>)")
        }
        failure {
            slackSend(channel: '#infrastructure-build', username: 'jenkins', message: "Uh Oh! Build ${env.JOB_NAME} ${env.BUILD_NUMBER} had a failure! (<${env.BUILD_URL}|Find out why>).")
        }
    }
}
