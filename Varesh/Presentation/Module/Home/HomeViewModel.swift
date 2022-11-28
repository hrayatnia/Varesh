import Foundation
import SwiftUI
import Stinsen

final class HomeViewModel: ViewModel {
    var cities: [CityInfo] = []

    @State var searchQuery: String = ""

    @RouterObject var router: NavigationRouter<AppCoordinator>!

    init(cities: [CityInfo]) {
        self.cities = cities
    }

    init() {}

    func showSetting() {
        router.coordinator.routeToSetting()
    }
}
