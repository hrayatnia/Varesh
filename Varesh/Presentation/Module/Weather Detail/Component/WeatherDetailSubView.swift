import SwiftUI
import KDesignSystem

struct WeatherDetailSubView<Content>: View where Content: View {
    private let title: String
    private let content: () -> Content
    private let axes: Axis.Set

    init(title: String,
         axes: Axis.Set = .vertical,
         content: @escaping () -> Content) {
        self.title = title
        self.content = content
        self.axes = axes
    }

    var body: some View {
        CardView {
            ZStack {
                VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
                VStack(alignment: .leading) {
                    HStack(alignment: .center) {
                        Image(systemName: "info.circle.fill")
                            .foregroundColor(.white)
                        Text(title).frame(alignment: .leading)
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                    .padding()
                    Divider().background(Color.white)
                    LazyListView(axes: axes) {
                        content()
                    }
                }
            }
        }.modifier(CardModifier(radius: 12.0))
    }
}

#if DEBUG
struct WeatherDetailHorizontalSubView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDetailSubView(title: "hourly forecast", axes: .horizontal) {
            VStack {
                HourlyForecastView()
                    .padding()
            }
        }
    }
}
#endif
