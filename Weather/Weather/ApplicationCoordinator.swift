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
    private let storage: StorageProtocol
    private let deepLink: DeepLink?
    private let disposeBag = DisposeBag()

    init(router: RouterProtocol, apiClient: WeatherApiClientProtocol, storage: StorageProtocol, deepLink: DeepLink? = nil) {
        self.router = router
        self.apiClient = apiClient
        self.storage = storage
        self.deepLink = deepLink
    }

    func start() {
        if let deepLink = deepLink {
            handleDeepLink(deepLink: deepLink)
        } else {
            runFlow()
        }
    }

    private func runFlow() {
        showLocationPicker(storage: storage)
    }

    private func showLocationPicker(storage: StorageProtocol) {
        let vm = LocationPickerViewModel(apiClient: apiClient, storage: storage)
        let vc = LocationPickerViewController(viewModel: vm)

        vc.didSelectLocation.subscribe(onNext: { [unowned self] location in
            self.pushWeatherDetails(location: location)
        }).disposed(by: disposeBag)

        router.set(vc)
    }

    private func pushWeatherDetails(location: LocationDto, animated: Bool = true) {
        let vm = WeatherDetailsViewModel(location: location, apiClient: apiClient)
        let vc = WeatherDetailsViewController(viewModel: vm)
        router.push(vc)
    }

    private func handleDeepLink(deepLink: DeepLink, animated: Bool = false) {
        switch deepLink {
        case .weatherDetails(let location):
            pushWeatherDetails(location: location, animated: animated)
        }
    }
}
