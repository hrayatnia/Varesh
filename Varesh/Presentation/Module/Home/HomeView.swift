import SwiftUI
import KDesignSystem
import Stinsen
struct HomeView: ViewProtocol {
    typealias ViewModelType = HomeViewModel

    var viewModel: ViewModelType

    @EnvironmentObject var appRouter: AppCoordinator.Router

    var body: some View {
        LazyListView {
            ForEach(viewModel.cities) { data in
                ZStack {
                    NavigationLink(destination: Text("Fuck you Apple")) {
                        EmptyView()
                    }
                    CityWeatherRow(viewModel: .init(city: data))
                }

            }
        }
        .padding()
        .navigationTitle("Weather".capitalized)
        .toolbar {
            Button(action: viewModel.showSetting, label: { Image(systemName: "gear") })
        }
        // .navigationBarSearch(viewModel.$searchQuery)
    }
}

#if DEBUG
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        AppCoordinator().view()
    }
}
#endif
