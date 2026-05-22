import Foundation
import Combine

// PRESENTER (El mensajero)
class AuthPresenter: ObservableObject {
    @Published var credentials = UserCredentials()
    @Published var errorMessage: String? = nil
    @Published var isLoading = false
    
    private let interactor: AuthInteractor
    private let router: AuthRouter
    
    init(interactor: AuthInteractor, router: AuthRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    // Función disparada por la Vista cuando tocan "Ingresar"
    @MainActor
    func loginTapped() {
        isLoading = true
        errorMessage = nil
        
        // Task nos permite usar llamadas asíncronas (async/await)
        Task {
            do {
                let uid = try await interactor.login(credentials: credentials)
                print("¡Bingo! Login exitoso de: \(uid)")
                isLoading = false
                router.navigateToDashboard()
            } catch {
                // Capturamos el error para mostrarlo bonito en pantalla
                isLoading = false
                
                // Si es un error de validación o Firebase, obtenemos la descripción localizada
                errorMessage = error.localizedDescription
            }
        }
    }
}
