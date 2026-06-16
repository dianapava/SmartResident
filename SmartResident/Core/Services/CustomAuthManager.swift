
import Foundation

class CustomAuthManager: AuthManagerProtocol {
    func login(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        
        // ⚠️ CAMBIA ESTA IP por la IP local real de tu PC vieja
        let urlString = "http://192.168.0.187:3000/api/login"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "InvalidURL", code: 400, userInfo: nil)))
            return
        }
        
        // Configurar la petición POST
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Empaquetar datos en JSON
        let body = ["email": email, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        // Disparar la petición por el Wi-Fi
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "NoData", code: 404, userInfo: nil)))
                return
            }
            
            // Traducir (Decodificar) la respuesta JSON de tu PC vieja
            do {
                let decoder = JSONDecoder()
                let responseDecoded = try decoder.decode(LoginResponse.self, from: data)
                
                // Si todo está bien, devolvemos el token que generó tu SQLite
                completion(.success(responseDecoded.token))
            } catch {
                completion(.failure(error))
            }
        }.resume() // Recuerda el .resume() para que se envíe la petición
    }
}


