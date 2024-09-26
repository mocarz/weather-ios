//
//  ApplicationCoordinator.swift
//  Weather
//
//  Created by Michal Mocarski on 25/09/2024.
//

import Foundation

class ApplicationCoordinator {
    private let router: RouterProtocol
    private let apiClient: WeatherApiClientProtocol

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
        router.set(vc)
    }
}
