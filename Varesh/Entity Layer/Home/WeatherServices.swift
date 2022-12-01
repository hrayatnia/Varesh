import Foundation
import KWeatherService
import CoreLocation

struct WeatherServices {

    func weatherForCity(name: String, for location: CLLocationCoordinate2D) async throws -> WeatherCityInfo {
        guard let data = try? await weather(for: location,
                                            range: .oneDay) else { throw WeatherNetworkError.notFound }
        return WeatherCityInfo(city: BasicWeatherModel(name: name, location: location),
                 time: "\(Date())",
                 weather: data)
    }

    func dailyForcast(for location: CLLocationCoordinate2D) async throws -> WeatherResponse {
        try await weather(for: location, range: .tenDay, timestep: .oneDay)
    }

    private func weather(for location: CLLocationCoordinate2D,
                         range: WeatherServices.Range,
                         timestep: WeatherRequestTimestamps = .oneHour) async throws -> WeatherResponse {
         let service = WeatherService(long: location.longitude,
                                      lat: location.latitude,
                                      range: range.rawValue,
                                      timestep: timestep,
                                      unit: AppSettings.shared.unit,
                                      fields: .temperature,
                                      .weatherCode,
                                      .sunrise,
                                      .sunset)
        await service.run()
        switch service.result {
        case .success(let data):
            return data
        case .failure(let error):
            throw error
        case .none:
            throw WeatherNetworkError.unkown
        }
    }

    private enum Range: String {
        case oneDay = "Plus1d"
        case tenDay = "Plus10d"
    }
}

enum WeatherNetworkError: LocalizedError {
    case notFound
    case unkown
}
