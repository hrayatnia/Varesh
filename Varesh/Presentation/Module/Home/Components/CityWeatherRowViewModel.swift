import Foundation
import SwiftUI
import KWeatherService
import Combine

struct CityInfo {
    let city: String
    let time: String
}

final class CityWeatherRowViewModel: ViewModel {

    var city: CityInfo
    var weather: WeatherResponse

    init(city: CityInfo, weather: WeatherResponse) {
        self.city = city
        self.weather = weather
    }
}

#if DEBUG

extension CityInfo {
    static func mock() -> Self {
        .init(city: "Munich", time: "6:42 PM")
    }
}

#endif
