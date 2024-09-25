//
//  Router.swift
//  Weather
//
//  Created by Michal Mocarski on 25/09/2024.
//

import Foundation
import UIKit

class Router: RouterProtocol {
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func push(_ viewController: UIViewController) {
        push(viewController, animated: true)
    }

    func push(_ viewController: UIViewController, animated: Bool) {
        navigationController.pushViewController(viewController, animated: animated)
    }

    func set(_ viewController: UIViewController) {
        set(viewController, animated: true)
    }

    func set(_ viewController: UIViewController, animated: Bool) {
        navigationController.setViewControllers([viewController], animated: animated)
    }

    func present(_ viewController: UIViewController) {
        present(viewController, animated: true)
    }

    func present(_ viewController: UIViewController, animated: Bool) {
        navigationController.present(viewController, animated: animated, completion: nil)
    }

    func dismiss() {
        dismiss(animated: true)
    }

    func dismiss(animated: Bool) {
        navigationController.dismiss(animated: animated, completion: nil)
    }

    func pop() {
        pop(animated: true)
    }

    func pop(animated: Bool) {
        navigationController.popViewController(animated: animated)
    }

    func popTo(_ viewController: UIViewController) {
        popTo(viewController, animated: true)
    }

    func popTo(_ viewController: UIViewController, animated: Bool) {
        navigationController.popToViewController(viewController, animated: animated)
    }

    func popToRoot() {
        popToRoot(animated: true)
    }

    func popToRoot(animated: Bool) {
        navigationController.popToRootViewController(animated: animated)
    }

    var first: UIViewController? {
        return navigationController.viewControllers.first
    }

    var top: UIViewController? {
        return navigationController.topViewController
    }
}
