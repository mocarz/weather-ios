//
//  RouterProtocol.swift
//  Weather
//
//  Created by Michal Mocarski on 25/09/2024.
//

import UIKit

protocol RouterProtocol {
    func push(_ viewController: UIViewController)
    func push(_ viewController: UIViewController, animated: Bool)
    func set(_ viewController: UIViewController)
    func set(_ viewController: UIViewController, animated: Bool)
    func present(_ viewController: UIViewController)
    func present(_ viewController: UIViewController, animated: Bool)
    func dismiss()
    func dismiss(animated: Bool)

    func pop()
    func pop(animated: Bool)
    func popTo(_ viewController: UIViewController)
    func popTo(_ viewController: UIViewController, animated: Bool)
    func popToRoot()
    func popToRoot(animated: Bool)

    var first: UIViewController? { get }
    var top: UIViewController? { get }
}
