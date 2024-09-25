//
//  ApplicationCoordinator.swift
//  Weather
//
//  Created by Michal Mocarski on 25/09/2024.
//

import Foundation

class ApplicationCoordinator {
    private let router: RouterProtocol

    init(router: RouterProtocol) {
        self.router = router
    }

    func start() {
        runFlow()
    }

    private func runFlow() {
        showLocationPicker()
    }

    private func showLocationPicker() {
        let vm = LocationPickerViewModel()
        let vc = LocationPickerViewController(viewModel: vm)
        router.set(vc)
    }
}
