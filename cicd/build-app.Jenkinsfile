pipeline {  
    agent any

    stages {
        stage('Build App APK') {
            steps {
                dir('app') {
                    sh 'nice flutter build apk --debug'
                    sh 'cp ./build/app/outputs/flutter-apk/app-debug.apk /app/app-debug-latest.apk'
                    echo 'The app build is now available at http://3.97.30.243:4000/app-debug-latest.apk'
                }            
            }
        }
    }
}