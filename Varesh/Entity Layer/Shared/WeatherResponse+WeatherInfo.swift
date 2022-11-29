import Foundation
import SwiftUI
import KWeatherService

extension WeatherResponse {
    struct WeatherInfo {
        let minimum: Int
        let maximum: Int
        let weatherCode: WeatherCode
        let current: Double
        let day: String?
        let hour: String?
        let sunrise: Date?
        let sunset: Date?

        func image() -> Image? {
            guard let sunrise = sunrise, let sunset = sunset else { return nil }
            return weatherCode.image(sunrise: sunrise, sunset: sunset)
        }
    }

    func current() -> WeatherInfo? {
        guard let closestInterval = closestInterval else { return nil}
        let data = WeatherInfo(minimum: 0,
                               maximum: 0,
                               weatherCode: WeatherCode(value: "\(closestInterval.values.weatherCode ?? 1001)"),
                               current: closestInterval.values.temperature ?? 0,
                               day: nil,
                               hour: closestInterval.startTime.hour,
                               sunrise: closestInterval.values.sunriseTime,
                               sunset: closestInterval.values.sunsetTime)
        return data
    }

    var lowest: Int {
        Int( data
            .timelines
            .first?
            .intervals
            .map { $0.values.temperature ?? 220 }.min() ?? 0.0)
    }

    var max: Int {
        let result = data
            .timelines
            .first?
            .intervals
            .map { $0.values.temperature ?? -100 }.max() ?? 0
        return Int(result)
    }

    var grouped: [Date: [Interval]] {
        self.data.timelines.first!.intervals.sliced(by: [Calendar.Component.year,
                                                         Calendar.Component.month,
                                                         Calendar.Component.day], for: \Interval.startTime)
    }
    func todayInterval() -> [Interval] {
        grouped[Date().get(.year, .month, .day).date ?? Date()] ?? []
    }

    var closestInterval: Interval? {
        grouped[grouped.keys.sorted().first {$0.timeIntervalSinceNow > 0 } ?? Date() ]?.first
    }
}

extension Interval: Identifiable {
    public var id: String {
        UUID().uuidString
    }
}
