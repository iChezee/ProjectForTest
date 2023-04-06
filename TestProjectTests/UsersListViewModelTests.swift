import XCTest
@testable import TestProject

class UsersListViewModelTests: XCTestCase {
    let networkService: NetworkService = MockNetworkService()
    let localStorage: LocalStorage = LocalStorageImpl()
    var viewModel: MockUsersListSceneViewModel {
        MockUsersListSceneViewModel(networkService: networkService, localStorage: localStorage)
    }
    
    override func setUp() {
        viewModel.fetchedUsers = []
        viewModel.isFiltered = false
        localStorage.eraseData()
    }
    
    func test_fetchMore_when_zeroUsers() throws {
        let response = UsersListResponse(page: 0, total: 0, totalPages: 0, users: [])
        let viewModel = viewModel
        viewModel.mockedResponse = response
        viewModel.fetchUsers()
        XCTAssert(viewModel.users.count == 0)
    }
    
    func test_fetchMore_when_finalPage() throws {
        let usersCount = 10
        let response = UsersListResponse(page: 1, total: usersCount, totalPages: 1, users: mockUsers(count: usersCount))
        let viewModel = viewModel
        viewModel.mockedResponse = response
        viewModel.fetchUsers()
        viewModel.loadNext()
        XCTAssert(viewModel.users.count == usersCount)
    }
    
    func test_fetchMore_when_pagesLessThenUsers() throws {
        let totalCount = 20
        let response = UsersListResponse(page: 1, total: totalCount, totalPages: 1, users: mockUsers(count: 10))
        let viewModel = viewModel
        viewModel.mockedResponse = response
        viewModel.fetchUsers()
        viewModel.loadNext()
        XCTAssert(viewModel.users.count == totalCount)
    }
    
    func test_fetch_when_refresh() throws {
        let count = 10
        let response = UsersListResponse(page: 1, total: 30, totalPages: 3, users: mockUsers(count: count))
        let viewModel = viewModel
        viewModel.mockedResponse = response
        viewModel.fetchUsers()
        viewModel.loadNext()
        XCTAssert(viewModel.users.count == count * 2)
        
        viewModel.refresh()
        XCTAssert(viewModel.users.count == count)
    }
    
    func test_fetch_when_filterEnabled() throws {
        let favourited = 2
        let response = UsersListResponse(page: 1, total: 30, totalPages: 3, users: mockFavouritedUsers(favourited, total: 10))
        let viewModel = viewModel
        viewModel.mockedResponse = response
        viewModel.isFiltered = true
        viewModel.fetchUsers()
        XCTAssert(viewModel.users.count == favourited)
    }
    
    func test_filterUsers_when_toogled() {
        let favourited = 2
        let total = 5
        let response = UsersListResponse(page: 1, total: 30, totalPages: 3, users: mockFavouritedUsers(favourited, total: total))
        let viewModel = viewModel
        viewModel.mockedResponse = response
        viewModel.fetchUsers()
        XCTAssert(viewModel.users.count == total)
        
        viewModel.filterClicked()
        XCTAssert(viewModel.isFiltered)
        XCTAssert(viewModel.users.count == favourited)
        
        viewModel.filterClicked()
        XCTAssert(!viewModel.isFiltered)
        XCTAssert(viewModel.users.count == total)
    }
    
    func test_favouriteUser_when_favouriteClicked() throws {
        let count = 5
        let response = UsersListResponse(users: mockUsers(count: count))
        let viewModel = viewModel
        viewModel.mockedResponse = response
        viewModel.fetchUsers()
        
        let index = Int.random(in: 0..<count)
        var randomUser = viewModel.users[index]
        randomUser.isFavourite = true
        
        viewModel.favouriteClicked(randomUser)
        XCTAssert(viewModel.users[index].isFavourite == randomUser.isFavourite)
    }
}

extension UsersListViewModelTests {
    func mockUsers(count: Int) -> [User] {
        var users = [User]()
        for index in 0..<count {
            let user = User(id: index)
            users.append(user)
        }
        return users
    }
    
    func mockFavouritedUsers(_ favourited: Int, total: Int) -> [User] {
        var users = [User]()
        for index in 0..<total {
            let user = User(id: index)
            if index < favourited {
                viewModel.favouriteClicked(user)
            }
            users.append(user)
        }
        return users
    }
}
