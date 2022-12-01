import Foundation
import KWeatherService

enum WeatherDetailError: Error {
    case limitReached
}

struct WeatherDetailUseCase {
    private static let limit: Int = 10

    private let weather: WeatherServices = .init()
    func saveCity(_ city: BasicWeatherModel) throws {
        if CityRepository.shared.count() <= WeatherDetailUseCase.limit {
            CityRepository.shared.add(city: city)
        } else {
            throw WeatherDetailError.limitReached
        }
    }

    func cityWeather(for location: BasicWeatherModel) async throws -> WeatherCityInfo {
        try await weather.weatherForCity(name: location.name,
                                          for: location.location)
    }

    func dailyForecast(for location: BasicWeatherModel) async throws -> WeatherResponse {
        try await weather.dailyForcast(for: location.location)
    }
}
