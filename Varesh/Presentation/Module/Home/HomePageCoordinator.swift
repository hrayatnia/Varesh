import SwiftUI
import Stinsen

final class HomePageCoordinator: Stinsen.NavigationCoordinatable {
    let stack = Stinsen.NavigationStack(initial: \HomePageCoordinator.start)

    @Root var start = makeStart
    @Route(.push) var setting = makeSettingView

    @ViewBuilder private func makeSettingView() -> some View {
        SettingView(viewModel: .init())
    }

    @ViewBuilder private func makeStart() -> some View {
        HomeView(viewModel: .init())
    }

}
