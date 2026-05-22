pipeline {
    agent any // En la vida real corporativa, aquí se restringe a agent { label 'mac' }

    stages {
        stage('Descargar Código') {
            steps {
                checkout scm
                echo '📦 Código descargado de la rama correctamente'
            }
        }
        
        stage('Construir (Build)') {
            steps {
                echo '🔨 Engranando motores: Compilando la aplicación de iOS...'
                // Usamos el comando nativo de Mac (xcodebuild) para compilar la app
                sh 'xcodebuild clean build -project SmartResident.xcodeproj -scheme SmartResident -destination "platform=iOS Simulator,name=iPhone 15"'
            }
        }
        
        stage('Correr Pruebas (Test)') {
            steps {
                echo '🧪 Pruebas unitarias en camino...'
                // Mismo comando, pero con la bandera "test"
                sh 'xcodebuild test -project SmartResident.xcodeproj -scheme SmartResident -destination "platform=iOS Simulator,name=iPhone 15"'
            }
        }
    }
    
    post {
        always {
            echo '🧹 Limpiando la casa después de trabajar...'
        }
        success {
            echo '✅ ¡CORONAMOS! El pipeline de Jenkins pasó limpiecito.'
        }
        failure {
            echo '❌ ¡PAILA! Alguien rompió el código o una gata se acostó en el teclado.'
        }
    }
}
