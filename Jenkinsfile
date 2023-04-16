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
                echo "Using POM file ${params.POM_FILE}"
                sh "mvn -f ${params.POM_FILE} -Dmaven.test.failure.ignore=true clean compile"
            }
            post {
                failure {
                    echo "Build failed"
                }
            }
        }
        stage('unit test'){
            steps {
                script {
                        if (fileExists('${params.POM_FILE}')) {
                                echo "Using POM file ${params.POM_FILE}"
                            } else {
                                error 'Cannot find POM file in ${params.POM_FILE}'
                            }
                        }
                sh "mvn -f ${params.POM_FILE} -Dgroups=org.kd.main.categories.UnitTests"
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