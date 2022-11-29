import Foundation

enum WeatherDetailError: Error {
    case limitReached
}

struct WeatherDetailUseCase {
    private static let limit: Int = 10
    func saveCity(_ city: CityModel) throws {
        if CityRepository.shared.count() <= WeatherDetailUseCase.limit {
            CityRepository.shared.add(city: city)
        } else {
            throw WeatherDetailError.limitReached
        }
    }
}
