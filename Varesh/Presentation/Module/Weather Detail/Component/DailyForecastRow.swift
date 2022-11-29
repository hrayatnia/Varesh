import SwiftUI
import KDesignSystem

struct DailyForecastRow: View {
    var body: some View {
        CardView {
            HStack(alignment: .center) {
                Text("Day")
                    .font(.headline)
                    .foregroundColor(.white)
                Image(systemName: "cloud.sun")
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
                Text("H: 14")
                    .font(.subheadline)
                    .foregroundColor(.white)
                Spacer(minLength: 24)
                Text("L: 0")
                    .font(.subheadline)
                    .foregroundColor(.white)
                Divider()
                    .background(Color.white)
            }
        }
    }
}

struct DailyForecastRow_Previews: PreviewProvider {
    static var previews: some View {
        DailyForecastRow()
    }
}
