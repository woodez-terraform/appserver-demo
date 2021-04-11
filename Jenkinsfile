pipeline {

  agent { label 'onprem' }


  stages {
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

    stage('Checkout') {
      steps {
        checkout scm
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
