import XCTest
@testable import SmartResident

// 1. MOCK SERVICE (El doble de riesgo)
// Creamos una versión "falsa" de Firebase para que nuestras pruebas
// sean rápidas como un rayo y no quemen peticiones a internet reales.
class MockAuthService: AuthServiceProtocol {
    var shouldFail = false
    
    func login(email: String, password: String) async throws -> String {
        if shouldFail {
            throw NSError(domain: "Test", code: 401, userInfo: [NSLocalizedDescriptionKey: "Credenciales falsas incorrectas"])
        }
        return "mock_user_id_123"
    }
    
    func register(email: String, password: String) async throws -> String {
        return "mock_new_user_id"
    }
}

// 2. SUITE DE PRUEBAS DEL INTERACTOR
final class AuthInteractorTests: XCTestCase {
    
    // SUT: System Under Test (El chivo expiatorio que vamos a probar)
    var sut: AuthInteractor!
    var mockService: MockAuthService!
    
    override func setUpWithError() throws {
        // Esto corre ANTES de empezar cada test individual
        mockService = MockAuthService()
        sut = AuthInteractor(authService: mockService)
    }
    
    override func tearDownWithError() throws {
        // Esto corre DESPUÉS de cada test para limpiar la basura
        sut = nil
        mockService = nil
    }
    
    // PRUEBA A: El Interactor no debe dejar pasar emails vacíos (Regla de negocio VIPER)
    func testLogin_ConEmailVacio_DeberiaLanzarError() async {
        let credencialesMalas = UserCredentials(email: "", password: "password123")
        
        do {
            _ = try await sut.login(credentials: credencialesMalas)
            XCTFail("El test falló porque el Interactor dejó pasar un email vacío")
        } catch let error as ValidationError {
            XCTAssertEqual(error, .emptyEmail)
            XCTAssertEqual(error.localizedDescription, "El correo no puede estar vacío, mija.")
        } catch {
            XCTFail("Se lanzó un tipo de error incorrecto: \(error)")
        }
    }
    
    // PRUEBA B: El Interactor no debe dejar pasar claves cortas
    func testLogin_ConClaveCorta_DeberiaLanzarError() async {
        let credencialesMalas = UserCredentials(email: "ale@test.com", password: "123")
        
        do {
            _ = try await sut.login(credentials: credencialesMalas)
            XCTFail("El test falló porque el Interactor aceptó una clave de 3 letras")
        } catch let error as AuthInteractor.ValidationError {
            XCTAssertEqual(error, .shortPassword)
            XCTAssertEqual(error.localizedDescription, "La contraseña es muy corta.")
        } catch {
            XCTFail("Se lanzó un tipo de error incorrecto: \(error)")
        }
    }
    
    // PRUEBA C: El Happy Path
    func testLogin_ConCredencialesBuenas_DeberiaRetornarUID() async throws {
        let credencialesBuenas = UserCredentials(email: "ale@test.com", password: "SuperPasswordGrosa123")
        
        // Aquí el Interactor le pasará la bola a nuestro MockAuthService
        let userId = try await sut.login(credentials: credencialesBuenas)
        
        XCTAssertEqual(userId, "mock_user_id_123", "El ID retornado no coincide con el del Mock falso")
    }
}

// 3. MOCK SESSION MANAGER (Para probar el Router)
class MockSessionManager: SessionManagerProtocol {
    var isLoggedIn: Bool = false
}

// 4. SUITE DE PRUEBAS DEL ROUTER
final class AuthRouterTests: XCTestCase {
    
    func testNavigateToDashboard_DeberiaActivarSesion() {
        // Arrange (Preparar)
        let mockSession = MockSessionManager()
        let router = AuthRouter(sessionManager: mockSession)
        
        // Act (Actuar)
        router.navigateToDashboard()
        
        // Assert (Asegurar)
        XCTAssertTrue(mockSession.isLoggedIn, "navigateToDashboard debería marcar isLoggedIn como true")
    }
}
