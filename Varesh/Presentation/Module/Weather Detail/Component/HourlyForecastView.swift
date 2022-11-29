import SwiftUI
import KWeatherService

struct HourlyForecastView: View {
    var info: Interval
    var body: some View {
        VStack(spacing: 6.0) {
            Text(info.startTime.hour)
                .font(.caption)
                .foregroundColor(.white)
            Image(systemName: "cloud.sun")
                .font(.headline)
                .foregroundColor(.white)
            Text("\(Int(info.values.temperature ?? 0))°")
                .font(.subheadline)
                .foregroundColor(.white)
        }
    }
}
