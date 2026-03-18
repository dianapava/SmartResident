import Foundation

// INTERACTOR (La lógica de negocio)
class AuthInteractor {
    // Inyectamos el servicio genérico. ¡Nunca inyectamos Firebase directamente!
    private let authService: AuthServiceProtocol
    
    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }
    
    func login(credentials: UserCredentials) async throws -> String {
        // Validación de negocio (¡esto no es trabajo de la View!)
        guard !credentials.email.isEmpty else {
            throw NSError(domain: "Auth", code: 400, userInfo: [NSLocalizedDescriptionKey: "El correo no puede estar vacío, mija."])
        }
        guard credentials.password.count >= 6 else {
            throw NSError(domain: "Auth", code: 400, userInfo: [NSLocalizedDescriptionKey: "La contraseña es muy corta."])
        }
        
        // Si todo está bien, mandamos al Firebase (o al servicio que esté conectado) a hacer el login
        return try await authService.login(email: credentials.email, password: credentials.password)
    }
}
