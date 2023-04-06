import Foundation

class ServiceManager {
    let baseURL: String = "https://reqres.in/api/users"
    
    let localStorage: LocalStorage
    let networkService: NetworkService
    
    init(localStorage: LocalStorage, networkService: NetworkService) {
        self.localStorage = localStorage
        self.networkService = networkService
    }
}

@propertyWrapper

struct DefaultServiceManager {
    var wrappedValue: ServiceManager {
        ServiceManager(localStorage: LocalStorageImpl(),
                       networkService: NetworkServiceImpl(baseURL: "https://reqres.in/api/users"))
    }
}
