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
    private let deepLink: DeepLink?
    private let disposeBag = DisposeBag()

    init(router: RouterProtocol, apiClient: WeatherApiClientProtocol, deepLink: DeepLink? = nil) {
        self.router = router
        self.apiClient = apiClient
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
        let vc = WeatherDetailsViewController()
        router.push(vc)
    }

    private func handleDeepLink(deepLink: DeepLink, animated: Bool = false) {
        switch deepLink {
        case .weatherDetails(let location):
            pushWeatherDetails(location: location, animated: animated)
        }
    }
}
