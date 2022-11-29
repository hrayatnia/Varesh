import SwiftUI

struct WeatherDetailHeaderView: View {
    var body: some View {
        VStack {
            Text("Munich")
                .font(.title)
                .foregroundColor(.white)
                .bold()
                .padding(4.0)
            Text("14°")
                .font(.largeTitle)
                .foregroundColor(.white)
            Text("cloudy")
                .font(.footnote)
                .foregroundColor(.white)
                .bold()
                .padding(4.0)
            Text("H: 16° L: 0°")
                .font(.footnote)
                .foregroundColor(.white)
        }
    }
}

#if DEBUG
struct WeatherDetailHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDetailHeaderView()
            .colorScheme(.dark)
    }
}
#endif
