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
          if (params.Action == 'Build') {
             sh "echo sh isFoo is ${params.Action}" 
          }
          else {
             sh "echo teardown on ${params.Acitioni}"
          }        
      }
    }      



  } 

}
