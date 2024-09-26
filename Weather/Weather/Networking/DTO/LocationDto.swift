//
//  LocationDto.swift
//  Weather
//
//  Created by Michal Mocarski on 25/09/2024.
//

import Foundation

struct LocationDto: Codable {
    let localizedName: String
    let country: CountryDto
    let key: String

    enum CodingKeys: String, CodingKey {
        case localizedName = "LocalizedName"
        case country = "Country"
        case key = "Key"
    }
}

struct CountryDto: Codable {
    let id: String
    let localizedName: String

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case localizedName = "LocalizedName"
    }
}
