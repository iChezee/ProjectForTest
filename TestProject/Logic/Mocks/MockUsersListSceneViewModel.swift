import Foundation

public class MockUsersListSceneViewModel: UsersListSceneViewModelImpl {
    public var mockedResponse: UsersListResponse = UsersListResponse()
    public var fetchedUsers: [User] = [User]()
    
    override public func fetchUsers() {
        saveDataFrom(mockedResponse)
        isLoading = false
    }
    
    override public func loadNext() {
        super.loadNext()
    }
}
