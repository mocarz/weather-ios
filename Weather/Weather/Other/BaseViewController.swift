//
//  BaseViewController.swift
//  Weather
//
//  Created by Michal Mocarski on 25/09/2024.
//

import Foundation
import UIKit
import RxSwift

class BaseViewController: UIViewController {
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
    }
}
