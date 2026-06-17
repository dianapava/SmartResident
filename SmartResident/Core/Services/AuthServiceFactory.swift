import Foundation

class AuthServiceFactory {
    static func makeAuthManager() -> AuthManagerProtocol {
        #if DEBUG
        return CustomAuthManager()
        #else
        return FirebaseAuthManager()
        #endif
    }
}
