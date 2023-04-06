import XCTest
import Combine
@testable import TestProject

final class ServicesTests: XCTestCase {
    let localStorage: LocalStorage = LocalStorageImpl()
    let networkService: NetworkService = MockNetworkService()
    
    var cancellables = Set<AnyCancellable>()
    
    override func setUp() {
        localStorage.eraseData()
    }
    
    func test_localStorage_when_user_favourited() throws {
        let user = mockUser()
        localStorage.toogleFavourite(user)
        assert(localStorage.isFavourite(user))
    }
    
    func test_localStorage_when_user_unfavourited() throws {
        let user = mockUser()
        localStorage.toogleFavourite(user)
        localStorage.toogleFavourite(user)
        assert(!localStorage.isFavourite(user))
    }
    
    func test_localStorage_when_user_not_favourited() throws {
        let user = User(id: 1)
        assert(!localStorage.isFavourite(user))
    }
}

extension ServicesTests {
    func mockUser() -> User {
        User(id: 0)
    }
}
