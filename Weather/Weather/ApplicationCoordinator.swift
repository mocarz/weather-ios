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
        showViewController()
    }

    private func showViewController() {
        let vc = ViewController()
        router.set(vc)
    }
}
