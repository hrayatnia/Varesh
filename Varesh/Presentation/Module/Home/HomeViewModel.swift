import Foundation
import SwiftUI
import Combine
import Stinsen
import CoreLocation

final class HomeViewModel: ViewModel {
    @Published var cities: [WeatherCityInfo] = []

    @Published var searchQuery: String = ""

    @Published var error: String = ""

    @Published var showError: Bool = false

    @RouterObject var router: NavigationRouter<HomePageCoordinator>!

    private var cancellable: AnyCancellable?

    private let useCase: HomeUseCase = .init()

    init(cities: [WeatherCityInfo]) {
        self.cities = cities
    }

    func load() {
        Task {
            await useCase.cities().asyncMap { [unowned self] data in
                do {
                    let data = try await getWeatherForCity(data)
                    DispatchQueue.main.async {
                        self.cities.removeAll(where: { data.city.name == $0.city.name })
                        self.cities.append(data)
                    }
                } catch let netError {
                    DispatchQueue.main.async {
                        self.error = netError.localizedDescription
                        self.showError = true
                    }
                }
            }
        }
        getLocation()
    }

    func showSetting() {
        router.route(to: \.setting)
    }

    func requestForLocation() {
        useCase.requestForLocation()
    }

    func getLocation() {
        cancellable = useCase.locationManager.locationUpdate.sink(receiveValue: { [unowned self] location in
            self.getCurrentLocationWeather(location)
        })
    }

    func getWeatherForCity(_ city: BasicWeatherModel) async throws -> WeatherCityInfo {
        try await useCase.cityWeather(for: city)
    }

    func getCurrentLocationWeather(_ location: CLLocation) {
        Task {
            guard let data = try? await self.useCase.cityWeather(for: .init(name: "Current Location", location: location.coordinate)) else { return }
            DispatchQueue.main.async {
                self.cities.append(data)
            }
        }
    }
}
