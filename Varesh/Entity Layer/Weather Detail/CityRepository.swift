import Foundation

struct CityRepository {

    static let shared: CityRepository = .init()
    private static let prefix = "city_"
    func add(city: CityModel) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(city) {
            UserDefaults.standard.setValue(encoded, forKey: CityRepository.prefix+city.id)
        }
    }

    func remove(city: CityModel) {
        UserDefaults.standard.removeObject(forKey: CityRepository.prefix+city.id)
    }

    func fetchCities() -> [CityModel] {
        UserDefaults
            .standard
            .dictionaryRepresentation()
            .keys
            .filter { $0.starts(with: CityRepository.prefix) }
            .compactMap { self.fetch(for: $0) }
    }

    func fetch(for key: String) -> CityModel? {
        if let result = UserDefaults.standard.object(forKey: key) as? Data {
            let decoder = JSONDecoder()
            if let data = try? decoder.decode(CityModel.self, from: result) {
                return data
            }
        }
        return nil
    }

    func count() -> Int {
        fetchCities().count
    }
}
