//
//  StorageProtocol.swift
//  Weather
//
//  Created by Michal Mocarski on 26/09/2024.
//

import Foundation

protocol StorageProtocol {
    func storeLocation(location: LocationDto)
    func getLocations() -> [LocationDto]
}
