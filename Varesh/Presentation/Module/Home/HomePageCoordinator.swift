import SwiftUI
import Stinsen

final class HomePageCoordinator: Stinsen.NavigationCoordinatable {
    let stack = Stinsen.NavigationStack(initial: \HomePageCoordinator.start)

    @Root var start = makeStart
    @Route(.push) var setting = makeSettingView
    @Route(.push) var weatherDetail = makeWeatherDetail
    @Route(.modal) var weatherDetailEditing = makeEditingWeatherDetail

    private func makeSettingView() -> SettingCoordinator {
        SettingCoordinator()
    }

    @ViewBuilder private func makeStart() -> some View {
        HomeView(viewModel: .init())
    }

    @ViewBuilder private func makeWeatherDetail(_ city: BasicWeatherModel) -> some View {
        WeatherDetailView(viewModel: .init(city: city))
    }

    @ViewBuilder private func makeEditingWeatherDetail(_ city: BasicWeatherModel) -> some View {
        WeatherDetailView(viewModel: .init(city: city), editing: true)
    }

}
