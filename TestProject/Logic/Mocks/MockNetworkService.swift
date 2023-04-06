import Foundation
import Combine

public class MockNetworkService: NetworkService {
    public init() { }
    
    public func fetchUsers(at page: Int) -> AnyPublisher<UsersListResponse, Error> {
        let users = mockUsers()
        let response = UsersListResponse(page: 1, total: 10, totalPages: 1, users: users)
        let subject = PassthroughSubject<UsersListResponse, Error>().append(response)
        return subject.eraseToAnyPublisher()
    }
    
    public func fetchSingleUser(by id: Int) -> AnyPublisher<User, Error> {
        let user = User(id: 0, email: "", firstName: "", lastName: "", avatar: URL(filePath: ""))
        let subject = PassthroughSubject<User, Error>().append(user)
        return subject.eraseToAnyPublisher()
    }
    
    func mockUsers() -> [User] {
        var users = [User]()
        for index in 0..<10 {
            users.append(User(id: index, email: "", firstName: "", lastName: "", avatar: URL(filePath: "")))
        }
        return users
    }
}
