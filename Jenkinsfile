pipeline {
    agent any

    tools{
        git 'Default'
    }

    triggers {
        cron('15 0 * * *')
    }

    parameters {
        string(name: 'POM_FILE', defaultValue: 'app/pom.xml', description: 'Path to the POM file')
    }

    stages {
        stage('checkout'){
            steps {
                git 'https://github.com/kdrzazga/Banque'
            }
            post {
                always {
                    echo 'Checkout finished.'
                }
                success {
                    echo "Project checked out from GH"
                }
            }
        }
        stage('build') {
            steps {
                sh "mvn -f ${params.POM_FILE} -Dmaven.test.failure.ignore=true clean compile"
            }
            post {
                failure {
                    echo "Build failed"
                }
            }
        }
        stage('test'){
            steps {
                sh "mvn -f ${params.POM_FILE} -Dmaven.test.failure.ignore=true test -Dgroups=org.kd.main.categories.UnitTests"
            }
            post {
                success {
                    echo "Tests passed"
                }
            }
        }
        stage('deploy'){
            when{
                expression{false} //DEPLOY is temporarily disabled
            }
            steps {
                script {
                    sh "docker build -t banque-img ."
                    sh "docker run -it banque-img"
                }
            }
        }
    }
}