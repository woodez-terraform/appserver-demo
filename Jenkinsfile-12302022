pipeline {

  agent { label 'onprem' }


  parameters{
      string(defaultValue: 'Project name', name: 'Project', description: 'When doing a show or teardown action all you need to define is project', trim: true )
      string( defaultValue: 'https://github.com/woodez-terraform/appserver-demo.git', description: 'your git repo for your code', name: 'GIT_URL', trim: true )
      choice(choices: ['Build', 'Teardown', 'Show'], description: 'Pick a action that you want to perform on your project', name: 'Action')
      choice(choices: ['Large', 'Medium', 'Small', 'Rhel8'], description: 'Select Size: Only needed for build action', name: 'Size')
      string(defaultValue: 'Enter Hostname', name: 'Hostname', description: 'Only needed for Build action', trim: true )
      string(defaultValue: 'Enter IP Adress', name: 'IPAddress', description: 'Only needed for Build action', trim:true )
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
                        echo 'Downloading the latest Terraform modules'
                        cd src
                        terraform get -update
                        terraform workspace select default
                        terraform init
                        terraform workspace new ${params.Project}
                        terraform workspace list
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
                       pwd
                       cd src
                       terraform workspace select ${params.Project}
                       terraform workspace list 
                       terraform apply -input=false myplan
                       rm -f myplan
                  """
              }

              else if (params.Action == "Teardown"){

                  sh """
                       cd src
                       terraform workspace select ${params.Project}
                       terraform workspace list
                       terraform destroy -auto-approve
                       terraform workspace select default
                       terraform workspace delete ${params.Project} 
                  """
              }
              
              else {

                  sh """
                       cd src               
                       terraform workspace select ${params.Project}
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
                    cd src
                    terraform workspace select ${params.Project}
                    terraform workspace list
                    terraform show
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
