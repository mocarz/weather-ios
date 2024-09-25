//
//  ViewModelBinding.swift
//  Weather
//
//  Created by Michal Mocarski on 25/09/2024.
//

import Foundation

protocol ViewModelBinding {
    associatedtype Inputs
    associatedtype Outputs

    func bind(_ inputs: Inputs) -> Outputs
}
