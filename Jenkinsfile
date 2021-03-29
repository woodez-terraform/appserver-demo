pipeline {

  agent compute01

  environment {
    SALTAPI_PORT=8080
    SALTAPI_CREDENTIALS_USR=terrasalt
    SALTAPI_CREDENTIALS_PSW=jandrew28
    SALTAPI_EAUTH=pam
    SALTAPI_SSL_VERIFY=False
    SALTAPI_PROTO=HTTPS
    TF_VAR_salt_master=192.168.2.208
  }

  stages {

    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('TF Plan') {
      steps {
          sh 'terraform init -backend-config="conn_str=postgres://tf_user:jandrew28@192.168.2.213/terraform_backend?sslmode=disable"'
          sh 'terraform plan -out myplan'
        }
      }      
    }

    stage('Approval') {
      steps {
        script {
          def userInput = input(id: 'confirm', message: 'Apply Terraform?', parameters: [ [$class: 'BooleanParameterDefinition', defaultValue: false, description: 'Apply terraform', name: 'confirm'] ])
        }
      }
    }

    stage('TF Apply') {
      steps {
          sh 'terraform apply -input=false myplan'
        }
      }
    }

  } 

}
