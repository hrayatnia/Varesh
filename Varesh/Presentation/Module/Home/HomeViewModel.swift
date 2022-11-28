import Foundation
import SwiftUI

final class HomeViewModel: ViewModel {
    var cities: [CityInfo] = []
    @State var searchQuery: String = ""
    init(cities: [CityInfo]) {
        self.cities = cities
    }

    init() {}
}
