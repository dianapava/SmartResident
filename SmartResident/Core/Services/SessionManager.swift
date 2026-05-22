import Combine

// MANAGER DE SESIÓN GLOBAL (El portero)
// Este parce se encarga de gritarle a la aplicación (SmartResidentApp) si el usuario ya entró o si apenas va a entrar.
class SessionManager: ObservableObject, SessionManagerProtocol {
    // Usamos el patrón "Singleton" (la misma instancia para toda la app) pa' que sea fácil de llamar
    static let shared = SessionManager()
    
    // Si esto cambia a true, las vistas que lo estén observando se van a recargar automáticamente
    @Published var isLoggedIn: Bool = false
    
    private init() {}
}


protocol SessionManagerProtocol: AnyObject {
    var isLoggedIn: Bool { get set }
}
