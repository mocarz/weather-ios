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
    private let apiClient: WeatherApiClientProtocol
    private let storage: StorageProtocol
    private let disposeBag = DisposeBag()

    init(apiClient: WeatherApiClientProtocol, storage: StorageProtocol) {
        self.apiClient = apiClient
        self.storage = storage
    }

    struct Inputs {
        let search: Observable<String>
        let locationSelected: Observable<LocationDto>
    }

    struct Outputs {
        let locationsShared: Observable<[LocationDto]>
    }

    func bind(_ inputs: Inputs) -> Outputs {
        inputs.locationSelected
            .subscribe(onNext: { [unowned self] location in
                self.storage.storeLocation(location: location)
            })
            .disposed(by: disposeBag)

        let locations = inputs.search
            .flatMapLatest({[unowned self] query -> Observable<[LocationDto]> in
                if query.isEmpty {
                    return .just(self.storage.getLocations())
                } else {
                    return Observable.just(query)
                        .distinctUntilChanged()
                        .throttle(.milliseconds(1000), scheduler: MainScheduler.instance)
                        .flatMapLatest({[unowned self] query -> Observable<[LocationDto]> in
                            return self.apiClient.searchLocations(query: query)
                        })
                }

            })
            .share(replay: 1)

        return Outputs(locationsShared: locations)
    }

}
