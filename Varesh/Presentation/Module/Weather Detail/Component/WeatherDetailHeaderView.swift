import SwiftUI

struct WeatherDetailHeaderView: View {
    @Binding var weather: WeatherCityInfo?
    var body: some View {
        VStack {
            Text(weather?.city.name ?? "---")
                .font(.title)
                .foregroundColor(.white)
                .bold()
                .padding(4.0)
            Text("\(Int(weather?.weather.current()?.current ?? 0))°")
                .font(.largeTitle)
                .foregroundColor(.white)
            Text(weather?.weather.current()?.weatherCode.rawValue ?? "")
                .font(.footnote)
                .foregroundColor(.white)
                .bold()
                .padding(4.0)
            Text("H: \(weather?.weather.max ?? 0)° L: \(weather?.weather.lowest ?? 0)°")
                .font(.footnote)
                .foregroundColor(.white)
        }
    }
}
