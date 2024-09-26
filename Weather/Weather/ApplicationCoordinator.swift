//
//  ApplicationCoordinator.swift
//  Weather
//
//  Created by Michal Mocarski on 25/09/2024.
//

import Foundation
import RxSwift

class ApplicationCoordinator {
    private let router: RouterProtocol
    private let apiClient: WeatherApiClientProtocol
    private let disposeBag = DisposeBag()

    init(router: RouterProtocol, apiClient: WeatherApiClientProtocol) {
        self.router = router
        self.apiClient = apiClient
    }

    func start() {
        runFlow()
    }

    private func runFlow() {
        showLocationPicker()
    }

    private func showLocationPicker() {
        let vm = LocationPickerViewModel(apiClient: apiClient)
        let vc = LocationPickerViewController(viewModel: vm)

        vc.didSelectLocation.subscribe(onNext: { [unowned self] location in
            self.pushWeatherDetails(location: location)
        }).disposed(by: disposeBag)

        router.set(vc)
    }

    private func pushWeatherDetails(location: LocationDto, animated: Bool = true) {
        let vm = WeatherDetailsViewModel(location: location)
        let vc = WeatherDetailsViewController(viewModel: vm)
        router.push(vc)
    }
}
