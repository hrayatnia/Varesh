import Foundation
import SwiftUI
import KWeatherService
import Combine

struct CityInfo: Identifiable {

    var id: String {
        self.city
    }

    let city: String
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
        .init(city: "Munich", time: "6:42 PM", weather: .mock())
    }
}

#endif
