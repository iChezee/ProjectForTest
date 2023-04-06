import SwiftUI

struct AvatarView: View {
    @DefaultServiceManager var manager
    
    let user: User
    var isTransitionAllowed: Bool = false
    let onFavouriteTap: (() -> Void)?
    
    init(user: User, isTransitionAllowed: Bool = false, onFavouriteTap: (() -> Void)? = nil) {
        self.user = user
        self.isTransitionAllowed = isTransitionAllowed
        self.onFavouriteTap = onFavouriteTap
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            if isTransitionAllowed {
                withNavigation
            } else {
                image
            }
            Image(manager.localStorage.isFavourite(user) ? Images.favouriteSelected.rawValue : Images.favouriteUnselected.rawValue)
                .resizable()
                .frame(width: .mediumLarge, height: .mediumLarge)
                .cornerRadius(.mediumLarge / 2)
                .padding([.top, .trailing], .zero)
                .onTapGesture {
                    onFavouriteTap?()
                }
        }
    }
    
    private var withNavigation: some View {
        NavigationLink {
            let viewModel = DetailsSceneViewModel(networkService: manager.networkService, id: user.id)
            DetailsScene(viewModel: viewModel)
        } label: {
            image
        }
    }
    
    private var image: some View {
        let size = CGFloat.extraLarge2
        return AsyncImage(url: user.avatar) { $0.resizable() } placeholder: {
            Image.placeholder.resizable()
        }
        .frame(width: size, height: size)
        .cornerRadius(size / 2)
        .background {
            let borderSize = size + 1
            Color.border
                .frame(width: borderSize, height: borderSize)
                .cornerRadius(borderSize / 2)
        }
    }
}
