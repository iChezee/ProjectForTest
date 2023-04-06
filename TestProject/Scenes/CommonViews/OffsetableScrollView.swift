import SwiftUI

struct OffsettableScrollView<T: View>: View {
    let axes: Axis.Set
    let showsIndicator: Bool
    let onSizeChanged: (CGSize) -> Void
    let onOffsetChanged: (CGPoint) -> Void
    let content: T
    
    private let sizeKey = "ScrollViewSize"
    private let originKey = "ScrollViewOrigin"
    
    init(axes: Axis.Set = .vertical,
         showsIndicator: Bool = true,
         onSizeChanged: @escaping (CGSize) -> Void = { _ in }, // TODO: React to scroll size chaging
         onOffsetChanged: @escaping (CGPoint) -> Void = { _ in },
         @ViewBuilder content: () -> T
    ) {
        self.axes = axes
        self.showsIndicator = showsIndicator
        self.onSizeChanged = onSizeChanged
        self.onOffsetChanged = onOffsetChanged
        self.content = content()
    }
    
    var body: some View {
        ScrollView(axes, showsIndicators: showsIndicator) {
            GeometryReader { proxy in
                Color.clear
                    .preference(key: SizePreferenceKey.self,
                                value: proxy.frame(in: .named(sizeKey)).size)
                    .preference(key: OffsetPreferenceKey.self,
                                value: proxy.frame(in: .named(originKey)).origin)
            }
            content
        }
        .coordinateSpace(name: originKey)
        .onPreferenceChange(OffsetPreferenceKey.self,
                            perform: onOffsetChanged)
    }
}

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) { }
}

struct OffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) { }
}
