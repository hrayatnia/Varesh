import Foundation
import KWeatherService
import CoreLocation

struct WeatherServices {

    func weatherForCity(name: String, for location: CLLocationCoordinate2D) async throws -> CityInfo {
        guard let data = try? await weather(for: location, range: .oneDay) else { throw WeatherNetworkError.notFound }
        return CityInfo(city: CityModel(name: name, location: location),
                 time: "\(Date())",
                 weather: data)
    }

    func hourlyForCast(for location: CLLocationCoordinate2D) async {
        try? await weather(for: location, range: .oneDay, timestep: .oneHour)
    }

    private func weather(for location: CLLocationCoordinate2D,
                         range: WeatherServices.Range,
                         timestep: WeatherRequestTimestamps = .oneDay) async throws -> WeatherResponse? {
         let service = WeatherService(long: location.longitude,
                                      lat: location.latitude,
                                      range: range.rawValue,
                                      timestep: timestep,
                                      unit: AppSettings.shared.unit,
                                      fields: .temperature,
                                      .weatherCode)
        await service.run()
        switch service.result {
        case .success(let data):
            return data
        case .failure(let error):
            throw error
        case .none:
            return nil
        }
    }

    private enum Range: String {
        case oneDay = "Plus1d"
        case tenDay = "Plus10d"
    }
}

enum WeatherNetworkError: Error {
    case notFound
}
