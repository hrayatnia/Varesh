import SwiftUI
import KDesignSystem

struct WeatherDetailView: ViewProtocol {
    typealias ViewModelType = WeatherDetailViewModel

    @ObservedObject var viewModel: WeatherDetailViewModel

    private let editing: Bool

    init(viewModel: WeatherDetailViewModel, editing: Bool = false) {
        self.viewModel = viewModel
        self.editing = editing
    }

    var body: some View {
        LazyListView {
            if editing {
                addAction
            }
            WeatherDetailHeaderView(weather: $viewModel.weatherInfo)
                .padding()
            WeatherDetailSubView(title: Constants.hourlyTitle.rawValue,
                                 axes: .horizontal) {
                ForEach(viewModel.weatherInfo?.weather.todayInterval ?? []) { data in
                    HourlyForecastView(info: data)
                        .padding()
                }
            }.padding()
            WeatherDetailSubView(title: Constants.dailyTitle.rawValue) {
                ForEach(0..<10) { _ in
                    DailyForecastRow()
                        .padding()
                }
            }
            .padding()
        }
        .background((viewModel.weatherInfo?.weather.current()?.image() ?? Image("clear-day"))
            .scaledToFill()
            .blur(radius: 24))
    }

    private var addAction: some View {
        HStack {
            Button(Constants.editingCancelButton.rawValue, action: viewModel.cancelAction)
                .foregroundColor(.white)
            Spacer()
            Button(Constants.editingAddButton.rawValue, action: viewModel.addCity)
                .foregroundColor(.white)
        }.padding()
    }

    private enum Constants: String {
        case editingCancelButton = "Cancel"
        case editingAddButton = "Add"
        case hourlyTitle = "hourly forecast"
        case dailyTitle = "Daily forecast"
    }
}
