import SwiftUI
import Combine

final class SearchResultViewModel: ViewModel {
    @Published var cities: [CityModel] = []
    private var useCase: SearchUseCase = .init()
    private var cancellable: AnyCancellable?

    init() {
        bindCities()
    }

    func search(for city: String) {
        useCase.search(city: city)
    }

    func bindCities() {
        cancellable = useCase
            .service
            .localSearchPublisher
            .sink(receiveValue: {[weak self] data in
                DispatchQueue.main.async {
                    self?.cities = data.map { .init(map: $0)}
                }
            })
    }
}
