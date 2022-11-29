import SwiftUI
import KDesignSystem
import KWeatherService

struct DailyForecastRow: View {
    var interval: Interval
    var body: some View {
        CardView {
            HStack(alignment: .center) {
                Text(interval.startTime.getWeekDay())
                    .font(.headline)
                    .foregroundColor(.white)
                WeatherCode(value: "\(interval.values.weatherCode ?? 1001)").systemImage()
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
                Text("H: --")
                    .font(.subheadline)
                    .foregroundColor(.white)
                Spacer(minLength: 24)
                Text("L: --")
                    .font(.subheadline)
                    .foregroundColor(.white)
                Divider()
                    .background(Color.white)
            }
        }
    }
}
