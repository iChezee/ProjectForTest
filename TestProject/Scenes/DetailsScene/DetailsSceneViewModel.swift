import Foundation
import Combine

class DetailsSceneViewModel: ObservableObject {
    @Published var user: User?
    
    private var cancellables = Set<AnyCancellable>()
    
    init(networkService: NetworkService, id: Int) {
        networkService.fetchSingleUser(by: id)
            .receive(on: DispatchQueue.main)
            .sink { _  in } receiveValue: { user in
                self.user = user
            }
            .store(in: &cancellables)
    }
}
