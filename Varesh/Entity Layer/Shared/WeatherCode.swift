import Foundation
import SwiftUI
import KWeatherService

enum WeatherCode: String {
    case clear = "clear"
    case cloudy = "cloudy"
    case rain = "rain"
    case snow = "snow"

    init(value: String) {
        switch value {
        case "1000", "1100":
            self = .clear
        case "1101", "1102", "1001":
            self = .cloudy
        case "4000", "4001", "4200", "4201", "6000", "6001", "6200", "6201":
            self = .rain
        case "5000", "5001", "5100", "5101", "7000", "7101", "7102":
            self = .snow
        default:
            self = .clear
        }
    }

    func image(sunrise: Date, sunset: Date) -> Image {
        let postfix = self.isDay(sunrise: sunrise, sunset: sunset) ? "-day" : "-night"
        return Image(self.rawValue + postfix)
    }

    private func isDay(sunrise: Date, sunset: Date) -> Bool {
        let date = Date()
        return date > sunrise && date < sunset
    }
}
