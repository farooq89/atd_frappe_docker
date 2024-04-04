pipeline {
    agent any

    environment {
        DOCKER_HUB_REPO = 'usman89/myrepo'
        IMAGE_NAME = 'frapee_atd_0.0.1'
        DOCKERHUB_CREDENTIALS= credentials('dockerhub')
    
    }
    stages {
        stage('Setting app.json variable') {
            steps {
                script {
                    // Define the APPS_JSON variable
                    def appsJson = '''
                        [{
                            "url": "https://x-token-auth:ATCTT3xFfGN01ZGPAktgG5e_SQ02ryC4NimdhgBHl57h0aQ0xsEdNyfyOytjlnCok-ErgKPeyRh24Kw31KtDNKVYxTMeaKNQj0sZL2ze8FGCJgNkbqCzXq_-lMU248UkkdGbOWo-4pVSSIYUDI1WnmpR5UYvO_GqwWys-8QmJcBGxm1M-6lKBnY=39B560F8@bitbucket.org/persona-lworkspace/associated-terminals.git",
                            "branch": "master"
                        }]
                    '''
                    
                    // Set the APPS_JSON environment variable123123
                    env.APPS_JSON = appsJson

                    // test123
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
                    --build-arg=FRAPPE_BRANCH=version-14 \
                    --build-arg=PYTHON_VERSION=3.11.6 \
                    --build-arg=NODE_VERSION=18.10.0 \
                    --build-arg=APPS_JSON_BASE64=$APPS_JSON_BASE64 \
                    --tag=usman89/myrepo:frapee_atd_0.0.1 \
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
        //                 docker build -t usman89/myrepo:frapee_atd_0.0.1 .
        //             '''
        //             sh '''
        //                 docker commit usman89/myrepo:frapee_atd_0.0.1
        //             '''
        //             sh '''
        //                 docker push usman89/myrepo:frapee_atd_0.0.1
        //             '''
        //         }
        //     }
        // }
        stage('Deployment'){
         steps{
            sshagent(credentials:['114']){
               script {
                        sh 'set -x'
                        sh '''
                            ssh -o StrictHostKeyChecking=no ubuntu@192.168.10.114 "
                                pwd \\
                                && echo "devops@m1cromerg3r" | sudo -S sudo su \\
                                && if [ -d ATD_frappe_docker ]
                                then
                                    cd ATD_frappe_docker
                                    sudo git pull
                                else
                                    git clone https://github.com/farooq89/ATD_frappe_docker.git
                                    cd ATD_frappe_docker
                                fi \\
                                && pwd \\
                                && sudo docker pull usman89/myrepo:frapee_atd_0.0.1\\
                                && sudo docker compose -f pwd.yml down \\
                                && sudo docker compose -f pwd.yml up -d \\
                                && sleep 100 
                            "
                       '''
                    }
                }
            }
        }
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