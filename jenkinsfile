pipeline{
    agent any
    stages{
        stage("terraform init"){
            steps{
                sh "terraform init"
            }
        }
        stage("terraform apply"){
            steps{
                sh "terraform apply -auto-approve"
            }
        }
        stage("save private key"){
            steps{
                sh "terraform output private_key >> ~/.ssh/id_rsa"
            }
        }
    }
}