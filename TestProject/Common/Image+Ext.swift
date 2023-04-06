import SwiftUI

enum Images: String {
    case placeholder
    case filter
    case appliedFilter
    case backButton
    case favouriteSelected
    case favouriteUnselected
}

extension Image {
    static let placeholder: Image = Image(Images.placeholder.rawValue)
    static let filter: Image = Image(Images.filter.rawValue)
    static let appliedFilter: Image = Image(Images.appliedFilter.rawValue)
    static let backButton: Image = Image(Images.backButton.rawValue)
    static let favouriteSelected: Image = Image(Images.favouriteSelected.rawValue)
    static let favouriteUnselected: Image = Image(Images.favouriteUnselected.rawValue)
}
