//
//  AccuWeatherLocationSearch.swift
//  Weather
//
//  Created by Michal Mocarski on 25/09/2024.
//

import Foundation

class AccuWeatherLocationSearchRequest: APIRequestProtocol {
    let method = RequestMethodType.GET
    let path = "locations/v1/cities/autocomplete"
    var parameters = [String: String]()

    init(query: String, apiKey: String) {
        parameters["q"] = query
        parameters["apikey"] = apiKey
    }
}
