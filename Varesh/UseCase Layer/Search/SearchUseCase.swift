import Foundation

struct SearchUseCase {
    private(set) var service: SearchCityService

    init(service: SearchCityService = .init()) {
        self.service = service
    }

    func search(city: String) {
        service.searchCities(searchText: city)
    }
}
