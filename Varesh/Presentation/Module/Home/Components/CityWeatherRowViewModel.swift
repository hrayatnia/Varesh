import Foundation
import SwiftUI
import KWeatherService
import Combine
import CoreLocation
import Stinsen

struct WeatherCityInfo: Identifiable, Hashable, Equatable {
    static func == (lhs: WeatherCityInfo, rhs: WeatherCityInfo) -> Bool {
        lhs.city == rhs.city
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(city)
    }

    var id: String {
        self.city.name
    }

    let city: BasicWeatherModel
    let time: String
    var weather: WeatherResponse
}

final class CityWeatherRowViewModel: ViewModel {

    @Published var city: WeatherCityInfo

    @RouterObject var router: NavigationRouter<HomePageCoordinator>!

    init(city: WeatherCityInfo) {
        self.city = city
    }

    func showDetail(_ city: BasicWeatherModel) {
        router.route(to: \.weatherDetail, city)
    }

}

#if DEBUG

extension WeatherCityInfo {
    static func mock() -> Self {
        .init(city: .init(name: "Munich",
                          location: .init(latitude: 41.0,
                                          longitude: 57.0)),
              time: "6:42 PM",
              weather: .mock())
    }
}

#endif
