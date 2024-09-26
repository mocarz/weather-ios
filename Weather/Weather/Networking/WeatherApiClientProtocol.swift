//
//  WeatherApiClientProtocol.swift
//  Weather
//
//  Created by Michal Mocarski on 25/09/2024.
//

import Foundation
import RxSwift

protocol WeatherApiClientProtocol {
    func searchLocations(query: String) -> Observable<[LocationDto]>
    func send<T: Codable>(apiRequest: APIRequestProtocol) -> Observable<T>
}
