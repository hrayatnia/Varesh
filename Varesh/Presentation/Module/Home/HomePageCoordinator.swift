import SwiftUI
import Stinsen

final class HomePageCoordinator: Stinsen.NavigationCoordinatable {
    let stack = Stinsen.NavigationStack(initial: \HomePageCoordinator.start)

    @Root var start = makeStart
    @Route(.push) var setting = makeSettingView
    @Route(.push) var weatherDetail = makeWeatherDetail
    @Route(.modal) var weatherDetailEditing = makeEditingWeatherDetail

    @ViewBuilder private func makeSettingView() -> some View {
        SettingView(viewModel: .init())
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
