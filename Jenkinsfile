pipeline {

  agent { label 'onprem' }

  parameters{
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

    stage('Setup parameters') {
      steps {

        script {
           parameters{[
               choice(
                   choices: ['Build', 'Teardown'],
                   description: 'what is action?',
                   name: 'Action'
               ),
               string(
                   defaultValue: 'scriptcrunch', 
                   name: 'hostname',
                   trim: true
               )
           ]}
        }
      }
    }


    stage('TF Plan') {
      steps {
         script {
              if (params.Action == "Build"){
                   sh "echo sh isFoo is ${params.Action}"
              }
              else {
                   sh "echo test"
              }
         } 
      }    
    }      



  } 

}
