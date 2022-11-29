import SwiftUI

struct HourlyForecastView: View {
    var body: some View {
        VStack(spacing: 6.0) {
            Text("9:00 AM")
                .font(.caption)
                .foregroundColor(.white)
            Image(systemName: "cloud.sun")
                .font(.headline)
                .foregroundColor(.white)
            Text("9")
                .font(.subheadline)
                .foregroundColor(.white)
        }
    }
}

#if DEBUG
struct HourlyForecastView_Previews: PreviewProvider {
    static var previews: some View {
        HourlyForecastView()
    }
}
#endif
