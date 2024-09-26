//
//  WeatherDetailsViewModel.swift
//  Weather
//
//  Created by Michal Mocarski on 26/09/2024.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

class WeatherDetailsViewModel: ViewModelBinding {
    private var apiClient: WeatherApiClientProtocol
    private var location: LocationDto

    init(location: LocationDto, apiClient: WeatherApiClientProtocol) {
        self.location = location
        self.apiClient = apiClient
    }

    struct Inputs {

    }

    struct Outputs {
        let city: Observable<String>
        let country: Observable<String>
        let weatherIconImage: Observable<UIImage>
        let temperature: Observable<Float>
        let weatherText: Observable<String>
    }

    func bind(_ inputs: Inputs) -> Outputs {
        let currentConditions = Observable.just(location.key)
            .filter({ $0 != ""})
            .distinctUntilChanged()
            .throttle(.milliseconds(1000), scheduler: MainScheduler.instance)
            .flatMapLatest({[unowned self] locationKey -> Observable<CurrentConditionsDto> in
                return self.apiClient.getCurrentConditions(locationKey: locationKey)
            })
            .share(replay: 1)

        let weatherIconImage = currentConditions
            .map { "weather-icon-\($0.weatherIcon)" }
            .map { UIImage(named: $0) }
            .unwrap()

        let temperature = currentConditions
            .map { $0.temperature.metric.value }

        let weatherText = currentConditions
            .map { $0.weatherText }

        return Outputs(
            city: Observable.just(location.localizedName),
            country: Observable.just(location.country.localizedName),
            weatherIconImage: weatherIconImage,
            temperature: temperature,
            weatherText: weatherText
        )
    }
}
