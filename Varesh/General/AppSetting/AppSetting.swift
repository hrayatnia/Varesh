import Combine
import SwiftUI
import KWeatherService
final class AppSettings: ObservableObject {

    static let shared = AppSettings()

    @AppStorage("current_theme") var currentTheme: Theme = .light
    @AppStorage("unit") var unit: WeatherUnitSystem = .metric

    var appInfo: [String: String] {
        [
            "Version": "\(Bundle.main.appVersionLong)",
            "App Name": "\(Bundle.main.appName)",
            "Copyrights": "\(Bundle.main.copyright)",
            "build version": "\(Bundle.main.appBuild)",
            "Language": "\(Bundle.main.language)"
        ]
    }
}
