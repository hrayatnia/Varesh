import Foundation
import SwiftUI
import Stinsen

final class HomeViewModel: ViewModel {
    var cities: [CityInfo] = [.mock()]

    @Published var searchQuery: String = ""

    @RouterObject var router: NavigationRouter<HomePageCoordinator>!

    private let useCase: HomeUseCase = .init()

    init(cities: [CityInfo]) {
        self.cities = cities
    }

    init() {
        cities += useCase.cities().map { .init(city: $0, time: "", weather: .mock()) }
    }

    func showSetting() {
        router?.route(to: \.setting)
    }

    func editView() {

    }

    func showDetail(_ city: CityModel) {
        router.route(to: \.weatherDetail, city)
    }
}
