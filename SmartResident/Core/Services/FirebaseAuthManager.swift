import Foundation
import Firebase
import FirebaseAuth

class FirebaseAuthManager: AuthManagerProtocol {
    func login(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        // Código real que conecta con los servidores de Google
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else {
                // Si tiene éxito, devolvemos un token (o string) identificador
                completion(.success(authResult?.user.uid ?? ""))
            }
        }
    }
}
