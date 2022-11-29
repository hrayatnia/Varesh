import SwiftUI
import KDesignSystem

struct CityWeatherRow: ViewProtocol {
    typealias ViewModelType = CityWeatherRowViewModel

    @StateObject var viewModel: ViewModelType

    var body: some View {

            CardView {
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text(viewModel.city.city.name)
                            .font(.title)
                            .foregroundColor(.white)
                            .bold()
                        Text(viewModel.city.weather.current()?.hour ?? "--:--")
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                    Spacer()
                    Text("\(Int(viewModel.city.weather.current()?.current ?? 0))°" )
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }.padding()
                HStack(alignment: .center) {
                    Text(viewModel.city.weather.current()?.weatherCode.rawValue ?? "----")
                        .font(.footnote)
                        .foregroundColor(.white)
                        .bold()
                    Spacer()
                    Text("H: --° L: --°")
                        .font(.footnote)
                        .foregroundColor(.white)
                }.padding()
            }
            .background(( viewModel.city.weather.current()?.image() ?? Image("clear-night")).blur(radius: 24))
            .modifier(CardModifier(radius: 24.0, shadow: .clear))
        }
}

#if DEBUG
struct CityWeatherRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LazyListView {
                ForEach(0..<10) { _ in
                    CityWeatherRow(viewModel: .init(city: .mock()))
                }
            }.padding()
                .navigationTitle("Weather".capitalized)
        }
    }

}
#endif
