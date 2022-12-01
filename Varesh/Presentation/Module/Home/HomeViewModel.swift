import Foundation
import SwiftUI
import Combine
import Stinsen
import CoreLocation

final class HomeViewModel: ViewModel {
    @Published var cities: [WeatherCityInfo] = []

    @Published var searchQuery: String = ""

    @RouterObject var router: NavigationRouter<HomePageCoordinator>!

    private var cancellable: AnyCancellable?

    private let useCase: HomeUseCase = .init()

    init(cities: [WeatherCityInfo]) {
        self.cities = cities
    }

    func load() {
        Task {
            await useCase.cities().asyncMap { [unowned self] data in
                self.cities.removeAll(where: { data.name == $0.city.name })
                guard let data = await getWeatherForCity(data) else { return }
                DispatchQueue.main.async {
                    self.cities.append(data)
                }
            }
        }
        getLocation()
    }

    func showSetting() {
        router.route(to: \.setting)
    }

//    func editView() {
//
//    }

    func showDetail(_ city: BasicWeatherModel) {
        router.route(to: \.weatherDetail, city)
    }

    func requestForLocation() {
        useCase.requestForLocation()
    }

    func getLocation() {
        cancellable = useCase.locationManager.locationUpdate.sink(receiveValue: { [unowned self] location in
            self.getCurrentLocationWeather(location)
        })
    }

    func getWeatherForCity(_ city: BasicWeatherModel) async -> WeatherCityInfo? {
        try? await useCase.cityWeather(for: city)
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
