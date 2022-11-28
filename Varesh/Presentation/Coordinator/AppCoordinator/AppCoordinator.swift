import Foundation
import SwiftUI
import Stinsen

final class AppCoordinator: NavigationCoordinatable {
    var stack: Stinsen.NavigationStack<AppCoordinator> =  Stinsen.NavigationStack(initial: \.start)

    @Root var start = makeStart

    func makeStart() -> some View {
        HomeView(viewModel: HomeViewModel())
    }
}
