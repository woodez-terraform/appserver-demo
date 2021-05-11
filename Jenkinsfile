pipeline {

  agent { label 'onprem' }


  parameters{
      string(defaultValue: 'Project name', name: 'Project', trim: true )
      string( defaultValue: 'https://github.com/woodez-terraform/appserver-demo.git', name: 'GIT_URL', trim: true )
      choice(choices: ['Build', 'Teardown'], description: 'what is action?', name: 'Action')
      choice(choices: ['Large', 'Medium', 'Small', 'Rhel8'], description: 'Select Size: ', name: 'Size')
      string(defaultValue: 'Enter Hostname', name: 'Hostname', trim: true )
      string(defaultValue: 'Enter IP Adress', name: 'IPAddress', trim:true )
      string(defaultValue: 'Enter Workspace', name: 'Workspace', trim:true )
  }


  stages {


    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('TF Plan') {
      steps {
          script {
              if (params.Action == "Build"){
                    sh """
                        echo \"test ${params.Action}\"
                        echo \"test ${params.Size}\"
                        echo \"test ${params.Hostname}\"
                        echo \"test ${params.IPAddress}\"
                        echo \"test ${params.Project}"
                        echo \"test ${params.Workspace}"
                        echo 'Downloading the latest Terraform modules'
                        cd src
                        terraform get -update
                        terraform init
                        terraform workspace select ${params.Workspace}
                        terraform workspace list
                        terraform show
                        terraform plan -var=\"hostname=${params.Hostname}\" -var=\"size=${params.Size}\" -var=\"ipaddy=${params.IPAddress}\" -var=\"vmpool=${params.Project}\" -out myplan
                    """
              }
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
          echo "You chose: ${params.Action}"
          script {
              if (params.Action == "Build"){
                  sh """ 
                       terraform workspace select ${params.Workspace}
                       terraform workspace list 
                       terraform -chdir=src apply -input=false myplan 
                       rm -f src/myplan
                  """
              }
              else {

                  sh """
                       cd src               
                       terraform workspace select ${params.Workspace}
                       terraform workspace list
                       terraform show
                  """
              }
          }

      }
   }


   stage('TF Show') {
     steps {
        script {
            if (params.Action == "Build"){
               sh """
                    terraform workspace select ${params.Workspace}
                    terraform workspace list
                    terraform -chdir=src show
               """
            }
            else {
                sh 'echo "Nothing deployed for this project"'
            }
        } 
     }
   }

  } 

}
