import Foundation
import CoreLocation

struct HomeUseCase {
    private(set) var locationManager: LocationModel = .init()

    private let weather: WeatherServices = .init()

    func cities() -> [BasicWeatherModel] {
        CityRepository.shared.fetchCities()
    }

    func requestForLocation() {
        locationManager.requestAuthorisation()
    }

    func cityWeather(for location: BasicWeatherModel) async throws -> WeatherCityInfo? {
        try? await weather.weatherForCity(name: location.name,
                                          for: location.location)
    }
}
