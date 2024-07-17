pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                checkout scmGit(branches: [[name: 'testjob']],
                     userRemoteConfigs: [[
                        url: 'git@github.com:ji-podhead/Pod-Shop-App-Configs.git',
                        credentialsId: 'PodShopApp'
                    ]])
            }
        }
        stage('Analyze Terraform Plan with Checkov') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'vault_token', variable: 'VAULT_TOKEN')]) {
                        sh '''
                                rm -f ./terraform/*.binary
                                rm -f ./terraform/*.xml
                                rm -f ./terraform/*.plan
                                rm -f ./terraform/*.json

                                cd ./terraform

                                terraform init
                                terraform plan -var="vault_token=${VAULT_TOKEN}" --out tfplan.binary
                                terraform show -json tfplan.binary | jq > tfplan.json
                                checkov -f tfplan.json -o junitxml > checkov_results.xml
                                chmod +x ./terraform/checkov_results.xml
                                cat ./terraform/checkov_results.xml
                                ls -la ./terraform/checkov_results.xml
                            '''
                    }
                }
            }
        }
    }
post {
    always {
        junit '*/**/*.xml'
        
        
 always {
            script {
                // Hier können Sie Ihre Checks veröffentlichen
               sh’echo "------ publish to git --------------"’
                //publishChecks(name: 'test', title: 'Test Check', summary: 'Check durch Pipeline')
            }
        }

    }
}

    options {
        preserveStashes()
        timestamps()
    }

}