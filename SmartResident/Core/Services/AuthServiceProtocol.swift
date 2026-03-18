import Foundation

// INTERFAZ DE SERVICIO (El enchufe universal)
// Aquí definimos QUÉ debe hacer el servicio de autenticación, pero NO CÓMO lo hace.
protocol AuthServiceProtocol {
    func login(email: String, password: String) async throws -> String
    func register(email: String, password: String) async throws -> String
}
