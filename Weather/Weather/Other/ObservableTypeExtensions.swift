//
//  ObservableTypeExtensions.swift
//  Weather
//
//  Created by Michal Mocarski on 26/09/2024.
//

import Foundation
import RxSwift

extension ObservableType {
    func unwrap<Result>() -> Observable<Result> where Element == Result? {
        return self.compactMap { $0 }
    }
}
