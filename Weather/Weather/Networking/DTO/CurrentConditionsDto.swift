//
//  CurrentConditionsDto.swift
//  Weather
//
//  Created by Michal Mocarski on 26/09/2024.
//

import Foundation

struct CurrentConditionsDto: Codable {
    let weatherText: String
    let temperature: TemperatureDto
    let weatherIcon: Int

    enum CodingKeys: String, CodingKey {
        case weatherText = "WeatherText"
        case temperature = "Temperature"
        case weatherIcon = "WeatherIcon"
    }
}

struct TemperatureDto: Codable {
    let metric: MetricDto

    enum CodingKeys: String, CodingKey {
        case metric = "Metric"
    }
}

struct MetricDto: Codable {
    let value: Float

    enum CodingKeys: String, CodingKey {
        case value = "Value"
    }
}
