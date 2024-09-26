//
//  MockWeatherApiClient.swift
//  Weather
//
//  Created by Michal Mocarski on 26/09/2024.
//

import Foundation
import RxSwift

class MockWeatherApiClient: WeatherApiClientProtocol {
    private let delayMs: Int

    init(delayMs: Int = 0) {
        self.delayMs = delayMs
    }

    func searchLocations(query: String) -> Observable<[LocationDto]> {
        let json = self.readBundleFile(forResource: "locations", withExtension: "json")

        let data = try! JSONDecoder().decode([LocationDto].self, from: json.data(using: .utf8)!)
        return Observable.just(data).observe(on: MainScheduler.asyncInstance)
            .delay(RxTimeInterval.milliseconds(self.delayMs), scheduler: MainScheduler.asyncInstance)
    }

    func getCurrentConditions(locationKey: String) -> Observable<CurrentConditionsDto> {
        let json = self.readBundleFile(forResource: "current_conditions", withExtension: "json")

        let data = try! JSONDecoder().decode([CurrentConditionsDto].self, from: json.data(using: .utf8)!)
        return Observable.just(data).observe(on: MainScheduler.asyncInstance)
            .map { $0.count > 0 ? $0[0] : nil}
            .delay(RxTimeInterval.milliseconds(self.delayMs), scheduler: MainScheduler.asyncInstance)
            .unwrap()
    }

    func send<T>(apiRequest: APIRequestProtocol) -> Observable<T> where T: Decodable, T: Encodable {
        fatalError()
    }

    private func readBundleFile(forResource: String, withExtension: String) -> String {
        let url = Bundle.main.url(forResource: forResource, withExtension: withExtension)!
        return try! String(contentsOf: url)
    }
}
