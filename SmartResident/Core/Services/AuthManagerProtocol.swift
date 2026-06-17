
import Foundation

protocol AuthManagerProtocol {
    func login(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void)
}
