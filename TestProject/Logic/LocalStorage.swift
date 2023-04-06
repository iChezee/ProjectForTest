import Foundation

public protocol LocalStorage {
    func isFavourite(_ user: User) -> Bool
    func toogleFavourite(_ user: User)
    func eraseData()
}

class LocalStorageImpl: LocalStorage {
    private var favouriteUsers = Set<Int>()
    private let localStorageSaveKey = "LocalStorageSaveKey"
    
    init() {
        if let favourites = UserDefaults.standard.object(forKey: localStorageSaveKey) as? [String] {
            favouriteUsers = Set(favourites.compactMap { Int($0) })
        }
    }
    
    func isFavourite(_ user: User) -> Bool {
        favouriteUsers.contains(user.id)
    }
    
    func toogleFavourite(_ user: User) {
        let userID = user.id
        if let _ = favouriteUsers.first(where: { $0 == userID }) {
            favouriteUsers.remove(userID)
        } else {
            favouriteUsers.insert(userID)
        }
        
        saveData()
    }
    
    func saveData() {
        let favourites = favouriteUsers.map { "\($0)" }
        UserDefaults.standard.set(favourites, forKey: localStorageSaveKey)
    }
    
    func eraseData() {
        favouriteUsers.removeAll()
        if UserDefaults.standard.value(forKey: localStorageSaveKey) != nil {
            UserDefaults.standard.set([String](), forKey: localStorageSaveKey)
        }
    }
}
