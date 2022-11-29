import SwiftUI
import Combine
import Stinsen
import KWeatherService

final class WeatherDetailViewModel: ViewModel {

    @RouterObject var router: NavigationRouter<HomePageCoordinator>!

    @Published var weatherInfo: WeatherCityInfo?

    @Published var hourlyInfo: WeatherCityInfo = .init(city: .init(name: .init(), location: .init()), time: .init(), weather: .init(data: .init(timelines: .init())))

    @Published var dailyWeahtherInfo: WeatherResponse = .init(data: .init(timelines: .init()))
    private(set) var city: BasicWeatherModel

    init(city: BasicWeatherModel, weatherInfo: WeatherCityInfo? = nil) {
        self.city = city
        self.weatherInfo = weatherInfo
        loadHeader()
        loadBody()
    }

    private var useCase: WeatherDetailUseCase = .init()

    func addCity() {
        try? useCase.saveCity(city)
        cancelAction()
    }

    private func loadHeader() {
        Task {
            guard let data = await getWeatherForCity(city) else { return }
            DispatchQueue.main.async {
                self.weatherInfo = data
                self.hourlyInfo = data
            }
        }
    }

    private func loadBody() {
        Task {
            guard let data = await tenDayForecast(city) else { return }
            DispatchQueue.main.async {
                self.dailyWeahtherInfo = data
            }
        }
    }
    private func getWeatherForCity(_ city: BasicWeatherModel) async -> WeatherCityInfo? {
        try? await useCase.cityWeather(for: city)
    }
    private func tenDayForecast(_ city: BasicWeatherModel) async -> WeatherResponse? {
        try? await useCase.dailyForecast(for: city)
    }

    func cancelAction() {
        router.popLast()
    }
}
