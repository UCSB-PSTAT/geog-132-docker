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
                        sh 'podman run -it --rm localhost/geog132 python -e "import otter"'
                    }
                
                }
            }
        }
    }
}
