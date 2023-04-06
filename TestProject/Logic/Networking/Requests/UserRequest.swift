import Foundation

struct UserRequest: Endpoint {
    var path: String
    var method: HTTPMethod = .get
    var headers: [String : String]?
    var queryParameters: [String : String]?
    
    init(id: Int) {
        self.path = "/\(id)"
    }
}

struct UserResponse {
    let user: User
}

extension UserResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case user = "data"
    }
}
