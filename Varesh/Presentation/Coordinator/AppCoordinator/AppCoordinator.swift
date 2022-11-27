import Foundation
import SwiftUI
import Stinsen

final class AppCoordinator: NavigationCoordinatable {
    var stack: NavigationStack<AppCoordinator> =  NavigationStack(initial: \.start)
    
    @Root var start = makeStart
    
    func makeStart() -> some View {
        return ContentView(viewModel: ContentViewModel())
    }
}
