import SwiftUI
import Combine
import Stinsen

final class WeatherDetailViewModel: ViewModel {

    @RouterObject var router: NavigationRouter<HomePageCoordinator>!

    private(set) var city: CityModel

    init(city: CityModel) {
        self.city = city
    }

    private var useCase: WeatherDetailUseCase = .init()

    func addCity() {
        try? useCase.saveCity(city)
    }

    func cancelAction() {
        router.popLast()
    }
}
