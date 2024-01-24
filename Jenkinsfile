pipeline {
    agent any

    environment {
        DOCKER_HUB_REPO = 'usman89/myrepo'
        IMAGE_NAME = 'frapee_atd_0.0.1'
        DOCKERHUB_CREDENTIALS= credentials('dockerhub')
        APPS_JSON = '[{"url": "https://x-token-auth:ATCTT3xFfGN01ZGPAktgG5e_SQ02ryC4NimdhgBHl57h0aQ0xsEdNyfyOytjlnCok-ErgKPeyRh24Kw31KtDNKVYxTMeaKNQj0sZL2ze8FGCJgNkbqCzXq_-lMU248UkkdGbOWo-4pVSSIYUDI1WnmpR5UYvO_GqwWys-8QmJcBGxm1M-6lKBnY=39B560F8@bitbucket.org/persona-lworkspace/associated-terminals.git","branch": "master"}]'
        // APPS_JSON_CONTENT = '''
        //     [
        //         {
        //             "url": "https://x-token-auth:ATCTT3xFfGN01ZGPAktgG5e_SQ02ryC4NimdhgBHl57h0aQ0xsEdNyfyOytjlnCok-ErgKPeyRh24Kw31KtDNKVYxTMeaKNQj0sZL2ze8FGCJgNkbqCzXq_-lMU248UkkdGbOWo-4pVSSIYUDI1WnmpR5UYvO_GqwWys-8QmJcBGxm1M-6lKBnY=39B560F8@bitbucket.org/persona-lworkspace/associated-terminals.git",
        //             "branch": "master"
        //         }
        //     ]
        // '''

        // // Base64 encode the apps.json content
        // APPS_JSON_BASE64 = sh(script: "echo \$(echo '${APPS_JSON_CONTENT}' | base64)", returnStdout: true)
        // APPS_JSON_BASE64 = sh(script: "echo \$(echo '${APPS_JSON_CONTENT}' | base64)", returnStdout: true)
    
    }
    stages {
        stage('Example Stage') {
            steps {
                script {
                    // Add the line to export APPS_JSON_BASE64
                    sh 'export APPS_JSON_BASE64=$(echo ${APPS_JSON} | base64 -w 0)'
                    
                    // Your other steps go here
                    // ...
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    sh '''
                    docker build \
                    --build-arg=FRAPPE_PATH=https://github.com/frappe/frappe \
                    --build-arg=FRAPPE_BRANCH=version-14 \
                    --build-arg=PYTHON_VERSION=3.11.6 \
                    --build-arg=NODE_VERSION=18.18.2 \
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
        stage('SSH to 114'){
         steps{
            sshagent(credentials:['114']){
               script {
                        sh '''
                            ssh -o StrictHostKeyChecking=no ubuntu@192.168.10.114 "
                                pwd \\
                                && if [ -d docker_frappe ]
                                then
                                    cd docker_frappe
                                    git pull
                                else
                                    git clone https://github.com/farooq89/ATD_frappe_docker.git
                                    cd ATD_frappe_docker
                                fi \\
                                && echo "devops@m1cromerg3r" | sudo -S sudo su \\
                                && sudo docker ps \\
                                && sudo docker compose -f pwd.yml down \\
                                && sudo docker compose -f pwd.yml up
                            "
                       '''
                    }
                }
            }
        }

    }
}