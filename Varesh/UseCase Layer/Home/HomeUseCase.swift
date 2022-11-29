import Foundation

struct HomeUseCase {

    func cities() -> [CityModel] {
        CityRepository.shared.fetchCities()
    }
}
