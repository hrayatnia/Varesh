import Foundation
import SwiftUI
import KWeatherService
import Combine
import CoreLocation

struct CityInfo: Identifiable {

    var id: String {
        self.city.name
    }

    let city: CityModel
    let time: String
    let weather: WeatherResponse
}

final class CityWeatherRowViewModel: ViewModel {

    var city: CityInfo

    init(city: CityInfo) {
        self.city = city
    }
}

#if DEBUG

extension CityInfo {
    static func mock() -> Self {
        .init(city: .init(name: "Munich",
                          location: .init(latitude: 41.0,
                                          longitude: 57.0)),
              time: "6:42 PM",
              weather: .mock())
    }
}

#endif
