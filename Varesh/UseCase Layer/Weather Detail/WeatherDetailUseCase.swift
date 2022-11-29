import Foundation

struct WeatherDetailUseCase {

    func saveCity(_ city: CityModel) {
        CityRepository.shared.add(city: city)
    }
}
