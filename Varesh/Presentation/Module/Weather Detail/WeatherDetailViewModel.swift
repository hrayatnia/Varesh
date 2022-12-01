import SwiftUI
import Combine
import Stinsen
import KWeatherService

final class WeatherDetailViewModel: ViewModel {

    @RouterObject var router: NavigationRouter<HomePageCoordinator>!

    @Published var weatherInfo: WeatherCityInfo?

    @Published var hourlyInfo: WeatherCityInfo = .init(city: .init(name: .init(), location: .init()), time: .init(), weather: .init(data: .init(timelines: .init())))

    @Published var dailyWeahtherInfo: WeatherResponse = .init(data: .init(timelines: .init()))

    @Published var error: String = ""

    @Published var showError: Bool = false

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

        taskTrier(city, { [unowned self] data in
            let data = try await self.getWeatherForCity(data)
            DispatchQueue.main.async {
                self.weatherInfo = data
                self.hourlyInfo = data
            }
        })
    }

    private func loadBody() {
      taskTrier(city, { [unowned self] data in
          let data = try await tenDayForecast(data)
          DispatchQueue.main.async {
              self.dailyWeahtherInfo = data
          }
      })
    }
    private func getWeatherForCity(_ city: BasicWeatherModel) async throws -> WeatherCityInfo {
        try await useCase.cityWeather(for: city)
    }
    private func tenDayForecast(_ city: BasicWeatherModel) async throws -> WeatherResponse {
        try await useCase.dailyForecast(for: city)
    }

    func cancelAction() {
        router.popLast()
    }

    private func taskTrier<D>(_ data: D, _ action: @escaping (D) async throws -> Void) {
        Task {
            do {
                try await action(data)
            } catch let netError {
                DispatchQueue.main.async {
                    self.error = netError.localizedDescription
                    self.showError = true
                }
            }
        }
    }
}
