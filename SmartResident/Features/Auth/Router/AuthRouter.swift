import SwiftUI

// ROUTER (El conductor)
class AuthRouter {
    @MainActor
    static func build() -> some View {
        let router = AuthRouter()
        
        // Mija pille: aquí es donde "Inyectamos" Firebase. 
        // El Interactor ni se entera.
        let authService = FirebaseAuthManager() 
        let interactor = AuthInteractor(authService: authService)
        let presenter = AuthPresenter(interactor: interactor, router: router)
        
        return AuthView(presenter: presenter)
    }
    
    func navigateToDashboard() {
        print("🚀 ¡Cambio de pantalla! Router: Vámonos pa'l Dashboard!")
        // Le avisamos al portero (SessionManager) que el man ya puede entrar.
        // Como SmartResidentApp lo está observando, mágicamente cambiará la vista raíz.
        SessionManager.shared.isLoggedIn = true
    }
}
