//
//  Storage.swift
//  Weather
//
//  Created by Michal Mocarski on 26/09/2024.
//

import Foundation

class Storage: StorageProtocol {
    private let locationsKey = "locationsKey"
    private let maxLocationsCount = 3

    private lazy var encoder = JSONEncoder()
    private lazy var decoder = JSONDecoder()

    func storeLocation(location: LocationDto) {
        var locations = getLocations()
        locations.append(location)
        locations = locations.suffix(maxLocationsCount)

        storeCustomObject(obj: locations, forKey: locationsKey)
    }

    func getLocations() -> [LocationDto] {
        let locations: [LocationDto]? = getCustomObject(forKey: locationsKey)
        return locations ?? []
    }

    private func storeCustomObject<T: Codable>(obj: T, forKey key: String) {
        let data = try? encoder.encode(obj)
        UserDefaults.standard.set(data, forKey: key)
    }

    private func getCustomObject<T: Codable>(forKey key: String) -> T? {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return nil
        }

        return try? decoder.decode(T.self, from: data)
    }
}
