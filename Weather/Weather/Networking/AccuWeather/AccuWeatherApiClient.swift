//
//  AccuWeatherApiClient.swift
//  Weather
//
//  Created by Michal Mocarski on 25/09/2024.
//

import Foundation
import RxSwift
import RxCocoa

class AccuWeatherApiClient: WeatherApiClientProtocol {
    private let baseURL = URL(string: "https://dataservice.accuweather.com/")!
    private let apiKey: String

    init(apiKey: String) {
        self.apiKey = apiKey
    }

    func searchLocations(query: String) -> Observable<[LocationDto]> {
        let request = AccuWeatherLocationSearchRequest(query: query, apiKey: apiKey)
        return self.send(apiRequest: request)
    }

    func getCurrentConditions(locationKey: String) -> Observable<CurrentConditionsDto> {
        return self.getAllCurrentConditions(locationKey: locationKey)
            .map { $0.count > 0 ? $0[0] : nil}
            .unwrap()
    }

    private func getAllCurrentConditions(locationKey: String) -> Observable<[CurrentConditionsDto]> {
        let request = AccuWeatherCurrentConditionsRequest(key: locationKey, apiKey: apiKey)
        return self.send(apiRequest: request)
    }

    func send<T: Codable>(apiRequest: APIRequestProtocol) -> Observable<T> {
        print("send request")
        let request = apiRequest.request(with: baseURL)
        return URLSession.shared.rx.data(request: request)
            .map({ data in
                try JSONDecoder().decode(T.self, from: data)
            })
            .observe(on: MainScheduler.asyncInstance)
    }
}
