pipeline {

  agent { label 'onprem' }


  parameters{
      string(defaultValue: 'Project name', name: 'Project', trim: true )
      string( defaultValue: 'https://github.com/woodez-terraform/appserver-demo.git', name: 'GIT_URL', trim: true )
      choice(choices: ['Build', 'Teardown'], description: 'what is action?', name: 'Action')
      string(defaultValue: 'Enter Hostname', name: 'Hostname', trim: true )
      string(defaultValue: 'Enter IP Adress', name: 'IPAddress', trim:true )
  }


  stages {

    stage('Checkout') {
      steps {
        checkout scm
      }
    }

hostname = "app01.woodez.net"

    stage('TF Plan') {
      steps {
          sh 'terraform -chdir=src init -backend-config="conn_str=postgres://tf_user:jandrew28@192.168.2.213/terraform_backend?sslmode=disable"'
          sh "echo test ${params.Action}"
          sh "echo test ${params.Hostname}"
          sh "echo test ${params.IPAddress}"
          sh "echo test ${params.Project}"
          sh "terraform -chdir=src plan -var=\"hostname=${params.Hostname}\"-out myplan"
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
          echo "You choose: ${params.Action}"
          sh 'terraform -chdir=src apply -input=false myplan' 
      }
   }

  } 

}
