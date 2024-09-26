//
//  AccuWeatherCurrentConditionsRequest.swift
//  Weather
//
//  Created by Michal Mocarski on 26/09/2024.
//

import Foundation

class AccuWeatherCurrentConditionsRequest: APIRequestProtocol {
    let method = RequestMethodType.GET
    var path = ""
    var parameters = [String: String]()

    init(key: String, apiKey: String) {
        path = "currentconditions/v1/\(key)"
        parameters["apikey"] = apiKey
    }
}
