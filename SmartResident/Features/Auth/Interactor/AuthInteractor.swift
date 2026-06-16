import Foundation

protocol AuthInteractorInputProtocol: AnyObject {
    // La variable que conecta de vuelta al Presenter
    var presenter: AuthInteractorOutputProtocol? { get set }
    
    // Las funciones que el Presenter le puede ordenar ejecutar al Interactor
    func executeLogin(credentials: UserCredentials)
}

class AuthInteractor: AuthInteractorInputProtocol {
    
    // 1. Declarar la propiedad usando el PROTOCOLO (no Firebase ni tu PC directamente)
    private let authManager: AuthManagerProtocol
    
    weak var presenter: AuthInteractorOutputProtocol?
    
    // 2. Inyección de Dependencias: Por defecto le pedimos la instancia a la Fábrica.
    // (Esto te permitirá pasarle un "Mock" en tus pruebas unitarias más adelante).
    init(authManager: AuthManagerProtocol = AuthServiceFactory.makeAuthManager()) {
        self.authManager = authManager
    }
    
    // 3. Ejecutar el login usando el manager inyectado
    func executeLogin(credentials: UserCredentials) {
        authManager.login(email: credentials.email, password: credentials.password) { [weak self] resultado in
            // Volvemos al hilo principal para actualizar la vista de iOS
            DispatchQueue.main.async {
                switch resultado {
                case .success(let token):
                    print("🎉 Login exitoso. Token: \(token)")
                    self?.presenter?.didLoginWithSuccess(token: token)
                case .failure(let error):
                    print("❌ Error en login: \(error.localizedDescription)")
                    self?.presenter?.didLoginWithFailure(error: error)
                }
            }
        }
    }
}

