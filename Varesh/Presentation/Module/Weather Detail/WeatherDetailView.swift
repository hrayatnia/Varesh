import SwiftUI
import KDesignSystem

struct WeatherDetailView: ViewProtocol {
    typealias ViewModelType = WeatherDetailViewModel

    @StateObject var viewModel: WeatherDetailViewModel = .init()

    var body: some View {
        LazyListView {
            WeatherDetailHeaderView()
                .padding()
            WeatherDetailSubView(title: "hourly forecast",
                                 axes: .horizontal) {
                ForEach(0..<10) { _ in
                    HourlyForecastView()
                        .padding()
                }
            }.padding()

            WeatherDetailSubView(title: "Daily forecast") {
                ForEach(0..<10) { _ in
                    DailyForecastRow()
                        .padding()
                }
            }
            .padding()
        }
        .background(Image("clear-night").blur(radius: 24))
    }
}

#if DEBUG
struct WeatherDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDetailView()
            .colorScheme(.dark)
    }
}
#endif
