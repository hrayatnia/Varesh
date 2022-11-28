import SwiftUI
import KDesignSystem

struct HomeView: ViewProtocol {
    typealias ViewModelType = HomeViewModel

    var viewModel: ViewModelType

    var body: some View {
        LazyListView {
            ForEach(viewModel.cities) {
                CityWeatherRow(viewModel: .init(city: $0))
            }
        }.padding()
            .navigationTitle("Weather".capitalized)
            .navigationBarSearch(viewModel.$searchQuery)
            .toolbar{
                Button { } label: { Image(systemName: "gear")}
            }

    }
}

#if DEBUG
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView(viewModel: .init(cities: [.mock()]))
        }
    }
}
#endif
