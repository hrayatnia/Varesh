import Foundation
import SwiftUI
import Combine
import Stinsen
import CoreLocation

final class HomeViewModel: ViewModel {
    @Published var cities: [CityInfo] = []

    @Published var searchQuery: String = ""

    @RouterObject var router: NavigationRouter<HomePageCoordinator>!

    private var cancellable: AnyCancellable?

    private let useCase: HomeUseCase = .init()

    init(cities: [CityInfo]) {
        self.cities = cities
    }

    init() {
        Task {
            await useCase.cities().asyncMap { data in
                guard let data = await getWeatherForCity(data) else { return }
                DispatchQueue.main.async {
                    self.cities.append(data)
                }
            }
        }
    }

    func showSetting() {
        router?.route(to: \.setting)
    }

//    func editView() {
//
//    }

    func showDetail(_ city: CityModel) {
        router.route(to: \.weatherDetail, city)
    }

    func requestForLocation() {
        useCase.requestForLocation()
    }

    func getLocation() {
        cancellable = useCase.locationManager.locationUpdate.sink(receiveValue: { [weak self] location in
            self?.getCurrentLocationWeather(location)
        })
    }

    func getWeatherForCity(_ city: CityModel) async -> CityInfo? {
        try? await useCase.cityWeather(for: city)
    }

    func getCurrentLocationWeather(_ location: CLLocation) {
        Task {
            guard let data = try? await self.useCase.cityWeather(for: .init(name: "Current Location", location: location.coordinate)) else { return }
            self.cities.append(data)
        }
    }
}
