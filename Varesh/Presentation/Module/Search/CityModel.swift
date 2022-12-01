import Foundation
import CoreLocation
import MapKit

struct BasicWeatherModel: Identifiable, Codable, Hashable {
    static func == (lhs: BasicWeatherModel, rhs: BasicWeatherModel) -> Bool {
        lhs.name == rhs.name
    }

    var id: String {
        name
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }

    var name: String
    var location: CLLocationCoordinate2D

    init(name: String, location: CLLocationCoordinate2D) {
        self.name = name
        self.location = location
    }

    init(map item: MKMapItem) {
        self.name = item.name ?? ""
        self.location = item.placemark.coordinate
    }
}
