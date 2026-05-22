import Foundation

enum ValidationError: LocalizedError, Equatable {
    case emptyEmail
    case shortPassword
    
    var errorDescription: String? {
        switch self {
        case .emptyEmail:
            return "El correo no puede estar vacío"
        case .shortPassword:
            return "La contraseña es muy corta."
        }
    }
}
