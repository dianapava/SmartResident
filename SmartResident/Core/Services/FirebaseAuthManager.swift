import Foundation
import FirebaseAuth // Parce, esto dará error hasta que instales el paquete en Xcode

// IMPLEMENTACIÓN CON FIREBASE (El trabajo sucio)
// Esta es la ÚNICA clase que sabe que Google existe en nuestro proyecto.
class FirebaseAuthManager: AuthServiceProtocol {
    
    func login(email: String, password: String) async throws -> String {
        // Llamada a la librería real de Firebase
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        // Retornamos el User ID
        return result.user.uid
    }
    
    func register(email: String, password: String) async throws -> String {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        return result.user.uid
    }
}
