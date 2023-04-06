import Foundation

public struct User: Hashable, Equatable {
    let id: Int
    let email: String
    let firstName: String
    let lastName: String
    let avatar: URL
    var isFavourite: Bool = false
    var fullName: String { "\(firstName) \(lastName)" }
    
//    public init(id: Int, email: String = "", firstName: String = "", lastName: String = "", avatar: URL = URL(filePath: ""), isFavourite: Bool = false) {
//        self.id = id
//        self.email = email
//        self.firstName = firstName
//        self.lastName = lastName
//        self.avatar = avatar
//        self.isFavourite = isFavourite
//    }
}

extension User: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}
