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
            WeatherDetailHeaderView()
                .padding()
            WeatherDetailSubView(title: Constants.hourlyTitle.rawValue,
                                 axes: .horizontal) {
                ForEach(0..<10) { _ in
                    HourlyForecastView()
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
        .background(Image("clear-day")
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

#if DEBUG
struct WeatherDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDetailView(viewModel: .init(city: .init(name: "Munich", location: .init())))
            .colorScheme(.dark)
    }
}
#endif
