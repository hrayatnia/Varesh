import Foundation

struct HomeUseCase {
    private let locationManager: LocationModel = .init()

    func cities() -> [CityModel] {
        CityRepository.shared.fetchCities()
    }

    func requestForLocation() {
        locationManager.requestAuthorisation()
    }
}
