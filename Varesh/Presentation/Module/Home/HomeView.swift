import SwiftUI
import KDesignSystem
import Stinsen
struct HomeView: ViewProtocol {
    typealias ViewModelType = HomeViewModel

    @StateObject var viewModel: ViewModelType

    @EnvironmentObject var appRouter: AppCoordinator.Router

    var body: some View {
        LazyListView {
            ForEach(viewModel.cities) { data in
                ZStack {
                    CityWeatherRow(viewModel: .init(city: data))
                }

            }
        }
        .padding()
        .navigationTitle(Constants.pageTitle.rawValue.capitalized)
        .toolbar {
            Button(action: viewModel.showSetting, label: { Image(systemName: Constants.systemImage.rawValue) })
        }
        .navigationBarSearch($viewModel.searchQuery, placeholder: Constants.searchPlaceholder.rawValue)
    }
    
    private enum Constants: String {
        case systemImage = "gear"
        case searchPlaceholder = "search for other cities"
        case pageTitle = "Weather"
    }
}

#if DEBUG
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        AppCoordinator().view()
    }
}
#endif
