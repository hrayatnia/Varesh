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
                        Text(viewModel.city.time)
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                    Spacer()
                    Text("14°")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }.padding()
                HStack(alignment: .center) {
                    Text("Cloudy")
                        .font(.footnote)
                        .foregroundColor(.white)
                        .bold()
                    Spacer()
                    Text("H: 16° L: 0°")
                        .font(.footnote)
                        .foregroundColor(.white)
                }.padding()
            }
            .background(Image("clear-night").blur(radius: 24))
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
