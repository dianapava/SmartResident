import Foundation
import Combine

protocol AuthInteractorOutputProtocol: AnyObject {
    // Lo que el Interactor llama cuando todo sale bien
    func didLoginWithSuccess(token: String)
    
    // Lo que el Interactor llama cuando ocurre un error (contraseña incorrecta, sin red, etc.)
    func didLoginWithFailure(error: Error)
}

// PRESENTER (El mensajero)
class AuthPresenter: ObservableObject, AuthInteractorOutputProtocol {
    @Published var credentials = UserCredentials()
    @Published var errorMessage: String? = nil
    @Published var isLoading = false
    
    private let interactor: AuthInteractor
    private let router: AuthRouter
    
    init(interactor: AuthInteractor, router: AuthRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    // 1. ✅ FUNCIÓN CUANDO TOCAN "INGRESAR" (Ahora es súper simple y limpia)
    @MainActor
    func loginTapped() {
        isLoading = true
        errorMessage = nil
        
        // Solo le ordenamos al Interactor que comience su trabajo. No esperamos el resultado aquí.
        interactor.executeLogin(credentials: credentials)
    }
    
    // ==========================================
    // 🚪 PUERTA DE SALIDA (Respuestas del Interactor)
    // ==========================================
    
    // 2. ✅ Se ejecuta cuando la PC vieja o Firebase confirman que el usuario existe
    func didLoginWithSuccess(token: String) {
        print("¡Bingo! Login exitoso. Token: \(token)")
        isLoading = false
        errorMessage = nil
        router.navigateToDashboard()
    }
    
    // 3. ✅ Se ejecuta si hubo contraseña incorrecta, error de red, etc.
    func didLoginWithFailure(error: Error) {
        isLoading = false
        // Capturamos el error para mostrarlo en rojo en la pantalla
        errorMessage = error.localizedDescription
    }
}
