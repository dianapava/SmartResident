
import SwiftUI
import FirebaseCore // Importamos el núcleo de Firebase

@main
struct SmartResidentApp: App {
    
    // Observamos el portero global
    @StateObject private var sessionManager = SessionManager.shared
    
    // Este `init` se ejecuta antes de que se muestre cualquier pantalla
    init() {
        // TRUCO DE SENIOR: Cuando corremos Unit Tests (Cmd + U), Xcode levanta la app entera.
        // Si Firebase intenta inicializarse sin un entorno válido, hace crash (abort).
        // Le indicamos explícitamente que NO prenda Firebase si estamos en modo Testing.
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] == nil {
            FirebaseApp.configure()
        } else {
            print("🧪 Modo Testing detectado. Omitiendo Firebase para no estallar.")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            // Aquí está la magia: dependiendo del estado, mostramos el Dashboard o el Login
            if sessionManager.isLoggedIn {
                DashboardRouter.build()
            } else {
                AuthRouter.build(sessionManager: sessionManager)
            }
        }
    }
}
