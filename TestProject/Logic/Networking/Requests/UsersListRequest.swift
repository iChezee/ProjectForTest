import Foundation

struct UsersListRequest: Endpoint {
    var path: String
    var method: HTTPMethod = .get
    var headers: [String : String]?
    var queryParameters: [String : String]?
    
    init(page: Int) {
        self.path = "?page=\(page)"
    }
}

public struct UsersListResponse {
    let page: Int
    let total: Int
    let totalPages: Int
    let users: [User]
    
    public init(page: Int = 0, total: Int = 0, totalPages: Int = 0, users: [User] = [User]()) {
        self.page = page
        self.total = total
        self.totalPages = totalPages
        self.users = users
    }
}

extension UsersListResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case page
        case total
        case totalPages = "total_pages"
        case users = "data"
    }
}
