pipeline {

  agent { label 'onprem' }

  parameters {
      choice(choices: ['Build', 'Teardown'], description: 'what is action?', name: 'Action')
  }

  stages {

    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('TF Plan') {
      steps {
          echo "You choose: ${params.Action}"
          sh 'terraform -chdir=src init -backend-config="conn_str=postgres://tf_user:jandrew28@192.168.2.213/terraform_backend?sslmode=disable"'
          sh 'terraform -chdir=src plan -out myplan'
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
          sh 'terraform -chdir=src apply -input=false myplan'
        }
    }

  } 

}
