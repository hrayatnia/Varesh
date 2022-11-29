import SwiftUI
import Combine
import Stinsen

final class SearchResultViewModel: ViewModel {
    @Published var cities: [CityModel] = []
    private var useCase: SearchUseCase = .init()
    private var cancellable: AnyCancellable?

    @RouterObject var router: NavigationRouter<HomePageCoordinator>!

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
                    self?.cities = Set(data).map { .init(map: $0) }
                }
            })
    }

    func showWeatherDetail(_ city: CityModel) {
        router.route(to: \.weatherDetailEditing, city)
    }
}
