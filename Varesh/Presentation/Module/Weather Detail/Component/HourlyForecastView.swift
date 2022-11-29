import SwiftUI
import KWeatherService

struct HourlyForecastView: View {
    var info: Interval
    var body: some View {
        VStack(spacing: 6.0) {
            Text(info.startTime.hour)
                .font(.caption)
                .foregroundColor(.white)
            WeatherCode(value: "\(interval.values.weatherCode ?? 1001)").systemImage()
                .font(.headline)
                .foregroundColor(.white)
            Text("\(Int(info.values.temperature ?? 0))°")
                .font(.subheadline)
                .foregroundColor(.white)
        }
    }
}
