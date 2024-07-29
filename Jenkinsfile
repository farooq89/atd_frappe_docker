pipeline {
    agent any

    environment {
        DOCKER_HUB_REPO = 'usman89/myrepo'
        IMAGE_NAME = 'Slim_v2'
        DOCKERHUB_CREDENTIALS= credentials('dockerhub')
        GITHUB_TOKEN = credentials('GIT_TOKEN')
    
    }
    stages {
        stage('Setting app.json variable') {
            steps {
                script {
                    // Define the APPS_JSON variablee
                    def appsJson = '''
                        [{
                            "url": "https://${GIT_TOKEN}@github.com/associated-terminals/associated_terminals.git",
                            "branch": "master"
                        }]
                    '''
                    
                    // Set the APPS_JSON environment variable
                    env.APPS_JSON = appsJson

                    // test1231
                    env.APPS_JSON_BASE64 = sh(script: "echo \${APPS_JSON} | base64 -w 0", returnStdout: true).trim()
                }
            }
        }
        stage('Build Custom Image') {
            steps {
                script {
                    sh '''
                    docker build \
                    --build-arg=FRAPPE_PATH=https://github.com/frappe/frappe \
                    --build-arg=FRAPPE_BRANCH=version-15 \
                    --build-arg=python:3.11-slim \
                    --build-arg=NODE_VERSION=18.10.0 \
                    --build-arg=APPS_JSON_BASE64=$APPS_JSON_BASE64 \
                    --tag=usman89/myrepo:Slim_v2 \
                    --file=images/custom/Containerfile .
                    '''
                }
            }
        }
        stage('Docker Hub login'){
            steps{
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
        }
        stage('Push to Docker Hub') {
            steps {
                script {
                        docker.image("${DOCKER_HUB_REPO}:${IMAGE_NAME}").push()
                        
                }
            }
        }
        // stage('code update') {
        //     steps {
        //         script {
        //             sh '''
        //                 docker build -t usman89/myrepo:version15 .
        //             '''
        //             sh '''
        //                 docker commit usman89/myrepo:version15
        //             '''
        //             sh '''
        //                 docker push usman89/myrepo:version15
        //             '''
        //         }
        //     }
        // }
        // stage('Deployment'){
        //  steps{
        //     sshagent(credentials:['114']){
        //        script {
        //                 sh 'set -x'
        //                 sh '''
        //                     ssh -o StrictHostKeyChecking=no ubuntu@192.168.10.114 "
        //                         pwd \\
        //                         && echo "devops@m1cromerg3r" | sudo -S sudo su \\
        //                         && if [ -d ATD_frappe_docker ]
        //                         then
        //                             cd ATD_frappe_docker
        //                             sudo git pull
        //                         else
        //                             git clone https://github.com/farooq89/ATD_frappe_docker.git
        //                             cd ATD_frappe_docker
        //                         fi \\
        //                         && pwd \\
        //                         && sudo docker pull usman89/myrepo:frapee-14_atd_0.0.1 \\
        //                         && sudo docker compose -f pwd.yml down \\
        //                         && sudo docker compose -f pwd.yml up -d \\
        //                         && sleep 100 
        //                     "
        //                '''
        //             }
        //         }
        //     }
        // }
    }
    post {
    always {
        script {
            if (currentBuild.resultIsBetterOrEqualTo("SUCCESS")) {
                slackSend(channel: '#atd_notifications', color: 'good', message: "Build successful on 192.168.10.114")
            } else {
                slackSend(channel: '#atd_notifications', color: 'danger', message: "Build failed!")
                }
            }
        }
    }
}