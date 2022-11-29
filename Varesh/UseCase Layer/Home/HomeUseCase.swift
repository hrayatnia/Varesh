import Foundation
import CoreLocation

struct HomeUseCase {
    private(set) var locationManager: LocationModel = .init()

    private let weather: WeatherServices = .init()

    func cities() -> [CityModel] {
        CityRepository.shared.fetchCities()
    }

    func requestForLocation() {
        locationManager.requestAuthorisation()
    }

    func cityWeather(for location: CityModel) async throws -> CityInfo? {
        try? await weather.weatherForCity(name: location.name,
                                          for: location.location)
    }
}
