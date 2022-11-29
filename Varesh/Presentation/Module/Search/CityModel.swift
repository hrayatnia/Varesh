import Foundation
import CoreLocation
import MapKit

struct CityModel: Identifiable {

    var id: String {
        name
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
