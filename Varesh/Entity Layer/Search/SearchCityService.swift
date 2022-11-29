import Foundation
import Combine
import MapKit

final class SearchCityService: NSObject, MKLocalSearchCompleterDelegate {
    let localSearchPublisher = PassthroughSubject<[MKMapItem], Never>()

    private var request: MKLocalSearchCompleter?

    override init() {
        super.init()
        request = MKLocalSearchCompleter()
        request?.delegate = self
    }

    public func searchCities(searchText: String) {
        request(resultType: .address, searchText: searchText)
    }

    public func searchPointOfInterests(searchText: String) {
        request(searchText: searchText)
    }

    private func request(resultType: MKLocalSearchCompleter.ResultType = .address,
                         searchText: String) {

        request?.region = MKCoordinateRegion(.world)
        request?.resultTypes = MKLocalSearchCompleter.ResultType([resultType])
        request?.queryFragment = searchText

    }

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        Task {
            let data = await completer.results.asyncMap { await location(by: $0.title) }.compactMap { $0 }
            self.localSearchPublisher.send(data)
        }
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {

        debugPrint(error.localizedDescription)
    }

    private func location(by title: String) async -> MKMapItem? {
            let request = MKLocalSearch.Request()
            request.naturalLanguageQuery = title
            request.region = MKCoordinateRegion(.world)
            let search = MKLocalSearch(request: request)
            return try? await search.start().mapItems.first
    }
}
