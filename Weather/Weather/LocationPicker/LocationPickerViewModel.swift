//
//  LocationPickerViewModel.swift
//  Weather
//
//  Created by Michal Mocarski on 25/09/2024.
//

import Foundation
import RxCocoa
import RxSwift

class LocationPickerViewModel: ViewModelBinding {
    private var apiClient: WeatherApiClientProtocol

    init(apiClient: WeatherApiClientProtocol) {
        self.apiClient = apiClient
    }

    struct Inputs {
        let search: Observable<String>
    }

    struct Outputs {
        let locationsShared: Observable<[LocationDto]>
    }

    func bind(_ inputs: Inputs) -> Outputs {
        let locations = inputs.search
            .filter({ $0 != ""})
            .distinctUntilChanged()
            .throttle(.milliseconds(1000), scheduler: MainScheduler.instance)
            .flatMapLatest({[unowned self] query -> Observable<[LocationDto]> in
                return self.apiClient.searchLocations(query: query)
            })
            .share(replay: 1)

        return Outputs(locationsShared: locations)
    }

}
