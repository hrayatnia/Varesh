import Foundation
import SwiftUI
import Stinsen

final class HomeViewModel: ViewModel {
    var cities: [CityInfo] = [.mock()]

    @State var searchQuery: String = ""

    @RouterObject var router: NavigationRouter<HomePageCoordinator>!

    init(cities: [CityInfo]) {
        self.cities = cities
    }

    init() {}

    func showSetting() {
        router?.route(to: \.setting)
    }
}
