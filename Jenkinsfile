pipeline {
    agent any
        stages {
        stage('Checkout') {
            steps {
                checkout scmGit(branches: [[name: 'development']],
                 userRemoteConfigs: [[
                    url: 'git@github.com:ji-podhead/Pod-Shop-App-Configs.git',
                    credentialsId: 'podshopcred'
                ]])
            }
        }
        stage('Check if pip is installed') {
            steps {
                script {
                    def pipInstalled = sh(script: 'python -c "import pip; print(pip.__version__)"', returnStdout: true).trim() != ''
                    if (!pipInstalled) {
                        echo "pip is not installed, installing now..."
                        sh '''
                            curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
                            python get-pip.py install pip
                        '''
                    }
                }
            }
        }
        stage('Check if Checkov is installed') {
            steps {
                script {
                    def checkovInstalled = sh(script: 'pip3 show checkov', returnStdout: true).trim() != ''
                    if (!checkovInstalled) {
                        echo "Checkov is not installed, installing now..."
                        sh 'pip3 install checkov'
                    }
                }
            }
        }
        stage('Analyze Terraform Plan with Checkov') {
            when { changeset pattern: '**/terraform/*' } // Entfernung des ungültigen 'directory'-Parameters            steps {
                sh '''
                    cd ./terraform
                    terraform init
                    terraform plan -out=tf.plan
                    terraform show -json tf.plan > tf.json
                    checkov -f tf.json
                '''
            }
        }
        
      //  stage('Kubernetes') {
       //     when {changeset(pattern: '**/*', directory: './k8s')}
      //      steps {
     //           // Kubernetes-Buildschritte
    //        }
   //     }
 
    
    options {
        preserveStashes()
        timestamps()
    }
}
