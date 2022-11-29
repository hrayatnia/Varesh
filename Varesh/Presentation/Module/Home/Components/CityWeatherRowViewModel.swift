import Foundation
import SwiftUI
import KWeatherService
import Combine
import CoreLocation

struct WeatherCityInfo: Identifiable {

    var id: String {
        self.city.name
    }

    let city: BasicWeatherModel
    let time: String
    let weather: WeatherResponse
}

final class CityWeatherRowViewModel: ViewModel {

    var city: WeatherCityInfo

    init(city: WeatherCityInfo) {
        self.city = city
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
