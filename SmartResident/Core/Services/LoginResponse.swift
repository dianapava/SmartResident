
struct LoginResponse: Codable {
    let mensaje: String
    let token: String
    let user: UserResponse
    
    struct UserResponse: Codable {
        let id: Int
        let email: String
    }
}
