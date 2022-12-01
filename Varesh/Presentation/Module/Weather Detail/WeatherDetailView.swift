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
                ForEach(viewModel.hourlyInfo.weather.data.timelines.first?.intervals ?? []) { data in
                    HourlyForecastView(info: data)
                        .padding()
                }
            }.padding()
            WeatherDetailSubView(title: Constants.dailyTitle.rawValue) {
                ForEach(viewModel.dailyWeahtherInfo.data.timelines.first?.intervals ?? []) { data in
                    DailyForecastRow(interval: data)
                        .padding()
                }
            }
            .padding()
        }
        .background((viewModel.weatherInfo?.weather.current()?.image() ?? Image("clear-day"))
            .resizable()
            .aspectRatio(contentMode: .fill)
            .clipped()
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
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
