import SwiftUI

struct DetailsScene: View {
    @Environment(\.presentationMode) private var presentationMode
    @State var viewModel: DetailsSceneViewModel
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    ZStack {
                        Color.foreground
                            .frame(width: .medium, height: .medium)
                            .cornerRadius(.medium / 2)
                        Image.backButton
                            .resizable()
                            .frame(width: .small, height: .small)
                            .padding(.trailing, .extraSmall2)
                    }
                }
                .padding(.leading, .small)
                Spacer()
            }
            .padding(.top, .large)
            
            if let user = viewModel.user {
                mainViewWith(user)
            } else {
                loadingState()
            }
        }
        .background(Color.background)
        .toolbar(.hidden)
        .navigationBarBackButtonHidden()
        .ignoresSafeArea(.all, edges: .all)
    }
    
    private func mainViewWith(_ user: User) -> some View {
        VStack(spacing: .medium) {
            AvatarView(user: user)
            Text(user.fullName)
            Text(user.email)
            Spacer()
        }
        .foregroundColor(.label)
        .padding(.horizontal, .large)
        .padding(.top, .mediumLarge)
    }
    
    private func loadingState() -> some View {
        VStack(spacing: .medium) {
            Image.placeholder
                .resizable()
                .frame(width: .extraLarge2, height: .extraLarge2)
            Rectangle()
                .frame(width: .extraLarge)
                .cornerRadius(.extraSmall)
        }
    }
}
