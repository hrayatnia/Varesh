import SwiftUI
import Combine
import Stinsen

final class WeatherDetailViewModel: ViewModel {

    @RouterObject var router: NavigationRouter<HomePageCoordinator>!

    @Published var weatherInfo: WeatherCityInfo?

    private(set) var city: BasicWeatherModel

    init(city: BasicWeatherModel, weatherInfo: WeatherCityInfo? = nil) {
        self.city = city
        self.weatherInfo = weatherInfo
        load()
    }

    private var useCase: WeatherDetailUseCase = .init()

    func addCity() {
        try? useCase.saveCity(city)
        cancelAction()
    }

    private func load() {
        Task {
            guard let data = await getWeatherForCity(city) else { return }
            DispatchQueue.main.async {
                self.weatherInfo = data
            }
        }

    }
    private func getWeatherForCity(_ city: BasicWeatherModel) async -> WeatherCityInfo? {
        try? await useCase.cityWeather(for: city)
    }

    func cancelAction() {
        router.popLast()
    }
}
