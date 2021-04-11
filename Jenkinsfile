pipeline {

  agent { label 'onprem' }

  parameters{
      string(defaultValue: 'Project name', name: 'Project', trim: true )
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

    stage('TF Plan') {
      steps {
         script {
              if (params.Action == "Build"){
                   sh "echo sh isFoo is ${params.Action}"
                   sh "echo sh isFoo is ${params.Hostname}"
                   sh "echo sh isFoo is ${params.IPAddress}"
                   sh "echo sh isFoo is ${params.Project}"
              
              }
              else {
                   sh "echo test ${params.Action}"
                   sh "echo test ${params.Hostname}"
                   sh "echo test ${params.IPAddress}"
                   sh "echo test ${params.Project}"
              }
         } 
      }    
    }      



  } 

}
