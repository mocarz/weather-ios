//
//  LocationPickerViewModel.swift
//  Weather
//
//  Created by Michal Mocarski on 25/09/2024.
//

import Foundation
import RxCocoa
import RxSwift

class LocationPickerViewModel: ViewModelBinding {

    struct Inputs {
        let search: Observable<String>
    }

    struct Outputs {
        let locations: Observable<[String]>
    }

    func bind(_ inputs: Inputs) -> Outputs {
        let locations = inputs.search
            .filter({ $0 != ""})
            .distinctUntilChanged()
            .map { search in ["Warszawa", "Gdańsk", "Wrocław"].filter { $0.starts(with: search) } }

        return Outputs(locations: locations)
    }

}
