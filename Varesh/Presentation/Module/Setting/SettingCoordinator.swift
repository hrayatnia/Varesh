import SwiftUI
import Stinsen

final class SettingCoordinator: Stinsen.NavigationCoordinatable {
    let stack = Stinsen.NavigationStack(initial: \SettingCoordinator.start)

    @Root var start = makeStart

    @ViewBuilder private func makeStart() -> some View {
        SettingView(viewModel: .init())
    }

}
