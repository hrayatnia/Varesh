import SwiftUI
import KDesignSystem
import Stinsen

struct HomeView: ViewProtocol {
    typealias ViewModelType = HomeViewModel

    @StateObject var viewModel: ViewModelType

    // @EnvironmentObject var appRouter: AppCoordinator.Router

    var body: some View {
        VStack {
            if viewModel.searchQuery.isEmpty {
                cityList
            } else {
                SearchResultView(text: $viewModel.searchQuery)
            }
        }
        .navigationBarSearch($viewModel.searchQuery,
                              placeholder: Constants.searchPlaceholder.rawValue)
        .onAppear {
            viewModel.requestForLocation()
            viewModel.load()
        }

    }

    private var cityList: some View {
        VStack {
            LazyListView {
                ForEach(viewModel.cities, id: \.city) { data in
                    CityWeatherRow(viewModel: .init(city: data))
                }
            }
            Spacer()
        }
        .emptyState($viewModel.cities.isEmpty) {
            VStack(alignment: .center) {
                Text(Constants.emptyState.rawValue)
                    .font(.headline)
            }
        }
        .padding()
        .navigationTitle(Constants.pageTitle.rawValue.capitalized)
        .toolbar {
            // Button(Constants.editButton.rawValue, action: { viewModel.editView() })
            Button(action: viewModel.showSetting, label: { Image(systemName: Constants.systemImage.rawValue) })
        }
    }

    private enum Constants: String {
        case systemImage = "gear"
        case searchPlaceholder = "search for other cities"
        case pageTitle = "Weather"
        case editButton = "Edit"
        case emptyState = "please add a city or enable your location service"
    }
}

#if DEBUG
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        AppCoordinator().view()
    }
}
#endif
