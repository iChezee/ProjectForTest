import Foundation
import Combine

public class UsersListSceneViewModelImpl: ObservableObject {
    @Published public var users = [User]()
    @Published public var isLoading = true
    @Published public var isFiltered = false
    
    private var fetchedUsers = [User]() {
        didSet {
            users = isFiltered ? filteredUsers() : fetchedUsers
        }
    }
    private var currentPage = 1
    private var totalPages = 0
    private var totalUsers = 0
    
    private let networkService: NetworkService
    private let localStorage: LocalStorage
    private var cancellables = Set<AnyCancellable>()
    
    init(networkService: NetworkService, localStorage: LocalStorage) {
        self.networkService = networkService
        self.localStorage = localStorage
        fetchUsers()
    }
    
    public func fetchUsers() {
        isLoading = true
        networkService.fetchUsers(at: currentPage)
            .receive(on: DispatchQueue.main)
            .sink { _ in } receiveValue: { [weak self] response in
                self?.saveDataFrom(response)
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }
    
    func saveDataFrom(_ response: UsersListResponse) {
        var users = response.users
        for index in 0..<users.count {
            users[index].isFavourite = localStorage.isFavourite(users[index])
        }
        
        fetchedUsers.append(contentsOf: users)
        totalPages = response.totalPages
        totalUsers = response.total
    }
    
    func filteredUsers() -> [User] {
        fetchedUsers.filter { $0.isFavourite }
    }
    
    public func favouriteClicked(_ user: User) {
        for (index, item) in fetchedUsers.enumerated() {
            if item.id == user.id {
                fetchedUsers[index].isFavourite.toggle()
                break
            }
        }
        
        localStorage.toogleFavourite(user)
    }
    
    public func filterClicked() {
        isFiltered.toggle()
        users = isFiltered ? filteredUsers() : fetchedUsers
    }
    
    public func refresh() {
        currentPage = 1
        fetchedUsers.removeAll()
        fetchUsers()
    }
    
    public func loadNext() {
        if totalPages < currentPage || fetchedUsers.count < totalUsers {
            currentPage += 1
            fetchUsers()
        }
    }
}
