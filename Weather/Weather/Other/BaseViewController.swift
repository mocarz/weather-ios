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
    
    func showErrorAlert(message: String) {
        showAlert(title: "Oops, something went wrong.", message: message)
    }
    
    func showErrorAlert(error: Error) {
        showErrorAlert(message: error.localizedDescription)
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Dismiss", style: .default)
        alertController.addAction(action)
        
        present(alertController, animated: true, completion: nil)
    }
}
